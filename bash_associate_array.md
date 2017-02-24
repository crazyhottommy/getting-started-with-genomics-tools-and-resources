### The problem
I am running [pyclone](http://compbio.bccrc.ca/software/pyclone/) recently to determine the clonality of our collected tumor samples.
It needs tumor purity (estimated from sequenza) for input. I have 24 samples, and I want to generate pyclone commands for all of them.

### The solution
I usually generate command by bash and then use another [bash wrapper](https://gist.github.com/crazyhottommy/60b42c15b74b261afe13871f058f43d2) 
to generate pbs files on HPC ((Thanks to @SBAmin).
now for each patient, I have two samples. How should I generate the commands? I am still better in R and Unix than python,
so I used the associated array in bash.

First, generate a file containing the tumor purity for each tumor:  

```bash
head -6 all_tumor_purity_no_header.txt
0.69	Pa25T1
0.26	Pa25T2
0.49	Pa26T1
0.37	Pa26T2
0.9	Pa27T1
0.92	Pa27T2
```
This bash script uses associate array to contain tumor purity.
read more at http://www.artificialworlds.net/blog/2012/10/17/bash-associative-array-examples/

`make_commands.sh`:

```bash
#! /bin/bash
set -euo pipefail

## build the array to contain the tumor purity, like a python dict
## have to declare by -A
declare -A cols

while read purity sample
do
    cols[$sample]=$purity
done < all_purity_no_header.txt 

echo ${cols[@]}

## generate commands
for i in Pa{25..37}
do
   echo PyClone run_analysis_pipeline --in_file ${i}T1_pyclone.tsv ${i}T2_pyclone.tsv --tumour_contents ${cols[${i}T1]} ${cols[${i}T2]} --samples ${i}T1 ${i}T2 --density pyclone_binomial --working_dir ${i}T_pyclone_analysis --min_cluster_size 2 --seed 123 --num_iters 50000 > ${i}_pyclone_commands.txt
done
```
```bash
chmod u+x make_commands.sh
./make_commands.sh
```

what you get:
`cat *commands.txt`
```
PyClone run_analysis_pipeline --in_file Pa25T1_pyclone.tsv Pa25T2_pyclone.tsv --tumour_contents 0.69 0.26 --samples Pa25T1 Pa25T2 --density pyclone_binomial --working_dir Pa25T_pyclone_analysis --min_cluster_size 2 --seed 123 --num_iters 50000
PyClone run_analysis_pipeline --in_file Pa26T1_pyclone.tsv Pa26T2_pyclone.tsv --tumour_contents 0.49 0.37 --samples Pa26T1 Pa26T2 --density pyclone_binomial --working_dir Pa26T_pyclone_analysis --min_cluster_size 2 --seed 123 --num_iters 50000
PyClone run_analysis_pipeline --in_file Pa27T1_pyclone.tsv Pa27T2_pyclone.tsv --tumour_contents 0.9 0.92 --samples Pa27T1 Pa27T2 --density pyclone_binomial --working_dir Pa27T_pyclone_analysis --min_cluster_size 2 --seed 123 --num_iters 50000
....
```

then:

```bash

find *commands.txt | parallel 'makemsub -a {} -j {/.} -o a -c 4 -t "48:00:00" -m 16g > {/.}.pbs'

for pbs in *pbs
do
  msub $pbs
  sleep 1
done
```
I usually do it for simple tasks. e.g. only one or two commands are evoked.
For more complex workflows, a workflow tool such as [snakemake](https://bitbucket.org/snakemake/snakemake/wiki/Home) is better.
