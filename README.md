### Linux commands
* [A Bioinformatician's UNIX Toolbox](http://lh3lh3.users.sourceforge.net/biounix.shtml#xargs) from Heng Li  
* [Linux command line exercises for NGS data processing](http://userweb.eng.gla.ac.uk/umer.ijaz/bioinformatics/linux.html)  
* [command line bootcamp](http://rik.smith-unna.com/command_line_bootcamp/?id=rca84m6nsz6c9ngnugt8uayvi) teaches you unix command step by step
* [bash one-liners for bioinformatics](https://github.com/crazyhottommy/oneliners)  
* [some of my bash one-liner collections](https://github.com/crazyhottommy/scripts-general-use/blob/master/Shell/bioingformatics_one_liner.md)
* [Use the Unofficial Bash Strict Mode (Unless You Looove Debugging)](http://redsymbol.net/articles/unofficial-bash-strict-mode/)
* [Defensive BASH Programming](http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming) very good read for bash programming.
* [Better Bash Scripting in 15 Minutes](http://robertmuth.blogspot.com/2012/08/better-bash-scripting-in-15-minutes.html?m=1)
* [bash pitfalls](http://mywiki.wooledge.org/BashPitfalls)
* [Advancing in the Bash Shell](http://samrowe.com/wordpress/advancing-in-the-bash-shell/)
* [Bash by example](https://www.ibm.com/developerworks/library/l-bash/)
* process substitution: [Using Names Pipes and Process Substitution in Bioinformatics](http://vincebuffalo.org/blog/2013/08/08/using-names-pipes-and-process-substitution-in-bioinformatics.html) [Handy Bash feature: Process Substitution](https://medium.com/@joewalnes/handy-bash-feature-process-substitution-8eb6dce68133#.uz5pj9yer)
* [NGS Advanced Beginner/Intermediate Shell](https://github.com/ngs-docs/2016-adv-begin-shell-genomics)
* Commonly used commands for PBS scheduler:[Monitoring and Managing Your Job](https://www.osc.edu/supercomputing/batch-processing-at-osc/monitoring-and-managing-your-job)
* people say awk is not part of bioinformats :) Still very useful parsing plain text files. [Steve's Awk Academy](http://troubleshooters.com/codecorn/awk/index.htm)
* [intro-bioinformatics: Website and slides for intro to bioinformatics class at Fred Hutch](https://github.com/fredhutchio/intro-bioinformatics)  
![](https://cloud.githubusercontent.com/assets/4106146/17654247/872f8716-6266-11e6-887d-cebd009dde6a.png)
* [tmate](https://tmate.io/):Instant terminal sharing
* [tmux](https://tmux.github.io/) is a terminal multiplexer similar to [`screen`](https://www.gnu.org/software/screen/manual/screen.html) but have more features.


* [All about redirection](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-3.html)

**Theory and quick reference**

There are 3 file descriptors, stdin, stdout and stderr (std=standard).

Basically you can:

redirect stdout to a file
redirect stderr to a file
redirect stdout to a stderr
redirect stderr to a stdout
redirect stderr and stdout to a file
redirect stderr and stdout to stdout
redirect stderr and stdout to stderr
1 'represents' stdout and 2 stderr.
A little note for seeing this things: with the less command you can view both stdout (which will remain on the buffer) and the stderr that will be printed on the screen, but erased as you try to 'browse' the buffer.

1. stdout 2 file

This will cause the ouput of a program to be written to a file.

         ls -l > ls-l.txt
        
Here, a file called 'ls-l.txt' will be created and it will contain what you would see on the screen if you type the command 'ls -l' and execute it.
2. stderr 2 file

This will cause the stderr ouput of a program to be written to a file.

         grep da * 2> grep-errors.txt
        
Here, a file called 'grep-errors.txt' will be created and it will contain what you would see the stderr portion of the output of the 'grep da *' command.
3. stdout 2 stderr

This will cause the stderr ouput of a program to be written to the same filedescriptor than stdout.

         grep da * 1>&2 
        
Here, the stdout portion of the command is sent to stderr, you may notice that in differen ways.
4. stderr 2 stdout

This will cause the stderr ouput of a program to be written to the same filedescriptor than stdout.

         grep * 2>&1
        
Here, the stderr portion of the command is sent to stdout, if you pipe to less, you'll see that lines that normally 'dissapear' (as they are written to stderr) are being kept now (because they're on stdout).
5. stderr and stdout 2 file

This will place every output of a program to a file. This is suitable sometimes for cron entries, if you want a command to pass in absolute silence.

         rm -f $(find / -name core) &> /dev/null 
        
This (thinking on the cron entry) will delete every file called 'core' in any directory. Notice that you should be pretty sure of what a command is doing if you are going to wipe it's output.

* change permissions of files  
each digit is for: user, group and other.  

`chmod 754 myfile`: this means the user has read, write and execute permssion; member in the same group has read and execute permission but no write permission; other people in the world only has read permission.  

4 stands for "read",  
2 stands for "write",  
1 stands for "execute", and  
0 stands for "no permission."  
So 7 is the combination of permissions 4+2+1 (read, write, and execute), 5 is 4+0+1 (read, no write, and execute), and 4 is 4+0+0 (read, no write, and no execute).  

It is sometimes hard to remember. one can use the letter:The letters u, g, and o stand for "user", "group", and "other"; "r", "w", and "x" stand for "read", "write", and "execute", respectively.  

`chmod u+x myfile`  
`chmod g+r myfile`


### Do not give me excel files!
* [convert xlsx to csv: xlsx2csv](https://github.com/dilshod/xlsx2csv)
* [csvkit](http://csvkit.readthedocs.io/en/latest/index.html#)
* [GNU datamash](https://www.gnu.org/software/datamash/)
* [tabtk](https://github.com/lh3/tabtk) Toolkit for processing TAB-delimited format from Heng Li, the author of `Samtools`, `BWA` and many others.


### How to name files
It is really important to name your files correctly! see a [ppt](https://rawgit.com/Reproducible-Science-Curriculum/rr-organization1/master/organization-01-slides.html) by Jenny Bryan.

Three principles for (file) names:
* Machine readable (do not put special characters and space in the name)  
* Human readable (Easy to figure out what the heck something is, based on its name, add slug)  
* Plays well with default ordering:   

1. Put something numeric first  

2. Use the ISO 8601 standard for dates (YYYY-MM-DD) 

3. Left pad other numbers with zeros  

![](https://cloud.githubusercontent.com/assets/4106146/17389870/5dfc54c4-59cd-11e6-9293-a1f8789c8352.png)

![](https://cloud.githubusercontent.com/assets/4106146/17389869/5df7f6f4-59cd-11e6-8715-86645243d70c.png)


**Good naming of your files can help you to extract meta data from the file name**  
* [dirdf](https://github.com/ropenscilabs/dirdf) Create tidy data frames of file metadata from directory and file names.

```r
> dir("examples/dataset_1/")
[1] "2013-06-26_BRAFWTNEG_Plasmid-Cellline-100_A01.csv"
[2] "2013-06-26_BRAFWTNEG_Plasmid-Cellline-100_A02.csv"
[3] "2014-02-26_BRAFWTNEG_FFPEDNA-CRC-1-41_D08.csv"
[4] "2014-03-05_BRAFWTNEG_FFPEDNA-CRC-REPEAT_H03.csv"
[5] "2016-04-01_BRAFWTNEG_FFPEDNA-CRC-1-41_E12.csv"

> library("dirdf")
> dirdf("examples/dataset_1/", template="date_assay_experiment_well.ext")
        date     assay           experiment well ext                                          pathname
1 2013-06-26 BRAFWTNEG Plasmid-Cellline-100  A01 csv 2013-06-26_BRAFWTNEG_Plasmid-Cellline-100_A01.csv
2 2013-06-26 BRAFWTNEG Plasmid-Cellline-100  A02 csv 2013-06-26_BRAFWTNEG_Plasmid-Cellline-100_A02.csv
3 2014-02-26 BRAFWTNEG     FFPEDNA-CRC-1-41  D08 csv     2014-02-26_BRAFWTNEG_FFPEDNA-CRC-1-41_D08.csv
4 2014-03-05 BRAFWTNEG   FFPEDNA-CRC-REPEAT  H03 csv   2014-03-05_BRAFWTNEG_FFPEDNA-CRC-REPEAT_H03.csv
```

### parallelization 

Using these tool will greatly improve your working efficiency and get rid of most of your `for loops`.  
1. [xargs](http://www.cyberciti.biz/faq/linux-unix-bsd-xargs-construct-argument-lists-utility/)  
2. [GNU parallel](https://www.gnu.org/software/parallel/). one of my post [here](http://crazyhottommy.blogspot.com/2016/03/the-most-powerful-uniux-commands-i.html)  
3. [gxargs](https://github.com/brentp/gargs) by Brent Pedersen. Written in GO.  

### Statistics
* [Essence of linear algebra](https://www.youtube.com/playlist?list=PLZHQObOWTQDPD3MizzM2xVFitgF8hE_ab)

#### packages for data wrangling, tidying and visualizing.  

* [biobroom](https://www.bioconductor.org/packages/release/bioc/html/biobroom.html):Turn Bioconductor objects into tidy data frames  
* [readr](https://github.com/hadley/readr)  
* [tidyr](https://github.com/hadley/tidyr)  
* [dplry](https://github.com/hadley/dplyr)  
* [csv fingerprint](http://setosa.io/blog/2014/08/03/csv-fingerprints/)
* [ggplot2](https://github.com/hadley/ggplot2)
* [ggplot2 tips](http://t-redactyl.io/tag/ggplot2.html)
* [A List of ggplot2 extensions](https://www.ggplot2-exts.org/)
* [ggforce](https://github.com/thomasp85/ggforce/tree/facets): facet_zoom() to zoom in part of the figure!
* [Plotting background data for groups with ggplot2](https://drsimonj.svbtle.com/plotting-background-data-for-groups-with-ggplot2?utm_campaign=Data%2BElixir&utm_medium=email&utm_source=Data_Elixir_92)
* [plotly for R](https://cpsievert.github.io/plotly_book/)
* [Make waffle (square pie) charts in R](https://github.com/hrbrmstr/waffle)
* Bring the power of R to the command line: [littler](http://dirk.eddelbuettel.com/blog/2016/08/07/#littler-0.3.1)  [Rio](https://github.com/jeroenjanssens/data-science-at-the-command-line/blob/master/tools/Rio) A wrapper by Jeroen Janssens, the author of [data science at the command line](http://datascienceatthecommandline.com/)
* [htmlwidgets for R](http://www.htmlwidgets.org/showcase_d3heatmap.html) including `d3heatmap` for interactive heatmaps.
* [focus() on correlations of some variables with many others](https://drsimonj.svbtle.com/how-does-one-variable-correlate-with-all-others)
* [Unit test in R](http://www.johnmyleswhite.com/notebook/2010/08/17/unit-testing-in-r-the-bare-minimum/)
* [sinaplot](https://cran.r-project.org/web/packages/sinaplot/vignettes/SinaPlot.html): an enhanced chart for simple and truthful representation of single observations over multiple classes
* [complexHeatmaps](https://bioconductor.org/packages/release/bioc/html/ComplexHeatmap.html)  
* [heatmap:gapmap](https://cran.rstudio.com/web/packages/gapmap/vignettes/simple_example.html)
* [dendsort](https://cran.r-project.org/web/packages/dendsort/index.html):Modular Leaf Ordering Methods for Dendrogram Nodes
* [dendextend](https://cran.r-project.org/web/packages/dendextend/vignettes/introduction.html#changing-a-dendrograms-structure)
* [Interactive Heat Maps for R Using plotly](https://github.com/talgalili/heatmaply)
* [Multiple plots on a page](https://stat545-ubc.github.io/block020_multiple-plots-on-a-page.html)
* [ggExtra](http://deanattali.com/2015/03/29/ggExtra-r-package/)
* [cowplot](https://github.com/wilkelab/cowplot) -- An add-on to the ggplot2 plotting package
* [Extract Tables from PDFs](https://github.com/leeper/tabulizer)
* [In-depth introduction to machine learning in 15 hours of expert videos](http://www.dataschool.io/15-hours-of-expert-machine-learning-videos/)
* [Data Analysis and Visualization Using R](http://varianceexplained.org/RData/)This is a course that combines video, HTML and interactive elements to teach the statistical programming language R.
* [These are the course notes for the Monash Bioinformatics Platform’s “R More” course](https://monashbioinformaticsplatform.github.io/r-more/)
* [gitbook: Getting used to R, RStudio, and R Markdown](https://ismayc.github.io/rbasics-book/index.html)
* [Efficient R programming](https://csgillespie.github.io/efficientR/)
* [R for Data Science](http://r4ds.had.co.nz/) by Garrett Grolemund and Hadley Wickham

### handling arguments at the command line

* [docopt.R](https://github.com/docopt/docopt.R) [tutorial](http://www.slideshare.net/EdwindeJonge1/docopt-user2014)
* [python version](http://docopt.org/)

### visualization in general

* [Nature Methods point of view data visulization](http://blogs.nature.com/methagora/2013/07/data-visualization-points-of-view.html)
* [A tutorial for the free Inkscape cross-platform vector graphics editor](https://github.com/fredhutchio/inkscape-tutorial)
* [gimp](https://www.gimp.org/downloads/) for bit-map based figures.

### python tips and tools

* [30 Python Language Features and Tricks You May Not Know About](http://sahandsaba.com/thirty-python-language-features-and-tricks-you-may-not-know.html#id1)
* [intermediatePython](https://github.com/crazyhottommy/intermediatePython)
* [The Hitchhiker’s Guide to Python!](http://docs.python-guide.org/en/latest/)
* [Python 3 for Scientists](http://python-3-for-scientists.readthedocs.io/en/latest/)
* [Python FAQ: Why should I use Python 3?](https://eev.ee/blog/2016/07/31/python-faq-why-should-i-use-python-3/)
* [gitbook: Computational and Inferential Thinking; The Foundations of Data Science](https://www.gitbook.com/book/ds8/textbook/details)
* [A collection of python courses online](http://bafflednerd.com/learn-python-online/)
* [tpot:A Python tool that automatically creates and optimizes machine learning pipelines using genetic programming.](https://github.com/rhiever/tpot)
* [Easy to use Python API wrapper to plot charts with matplotlib, plotly, bokeh and more](https://github.com/cuemacro/chartpy):chartpy creates a simple easy to use API to plot in a number of great Python chart libraries like plotly (via cufflinks), bokeh and matplotlib, with a unified interface. You simply need to change a single keyword to change which chart engine to use (see below), rather than having to learn the low level details of each library.
* [Top 8 resources for learning data analysis with pandas](http://www.dataschool.io/best-python-pandas-resources/)

### machine learning

* [Practical Machine Learning with Python: standford crowd course](http://crowdcourse.stanford.edu/ml.html)


### Papers
* 2016 review [Coming of age: ten years of next-generation sequencing technologies](http://www.nature.com/nrg/journal/v17/n6/full/nrg.2016.49.html)
* [Cancer genomics — from bench to bedside: review papers from Nature](http://www.nature.com/collections/dswwtfkdty?BAN_NRG_1602_CANCERCOLLECTION_PORTFOLIO)

### Genomics-visualization-tools

There are many online web based tools for visualization of (cancer) genomic data. I put my collections here. I use R for visulization.
see a nice post by using python by Radhouane Aniba:[Genomic Data Visualization in Python](http://fullstackdatascientist.io/2016-03-15-genomic-data-visualization-using-python/)

* [UCSC cancer genome browser](https://genome-cancer.ucsc.edu/proj/site/hgHeatmap/) It has many data including TCGA data buit in, and can be very handy for both bench scientist and bioinformaticians.  
* [UCSC Xena](http://xena.ucsc.edu/). A new tool developed by UCSC team as well. Poteintially very useful, but need more tutorials to follow.
* [UCSC genome browser](http://genome.ucsc.edu/). One of the most famous genome browser and my favoriate. **Every person** studying genetics, genomics and molecular biology needs to know how to use it. [Tutorials from OpenHelix](http://blog.openhelix.eu/?p=22649).  
* [Epiviz 3](http://epiviz.github.io/index.html) is an interactive visualization tool for functional genomics data. It supports genome navigation like other genome browsers, but allows multiple visualizations of data within genomic regions using scatterplots, heatmaps and other user-supplied visualizations. 
* Mutation Annotation & Genome Interpretation TCGA: [MAGA](http://magi.brown.edu/)
* [GeneProteinViz (GPViz)](http://icbi.at/software/gpviz/gpviz.shtml) is a versatile Java-based software for dynamic gene-centered visualization of genomic regions and/or variants.
* [ProteinPaint: Web Application for Visualizing Genomic Data](https://pecan.stjude.org/proteinpaint/TP53/) The software developed for this project highlights critical attributes about the mutations, including the form of protein variant (e.g. the new amino acid as a result of missense mutation), the name of sample from which the mutation was identified, whether the mutation is somatic or germline,

### Databases
* [DisGeNET](http://www.disgenet.org/web/DisGeNET/menu/home?utm_source=twitterfeed&utm_medium=twitter) is a discovery platform integrating information on gene-disease associations (GDAs) from several public data sources and the literature
* [Cancer3D](http://cancer3d.org/) is a database that unites information on somatic missense mutations from TCGA and CCLE, allowing users to explore two different cancer-related problems at the same time: drug sensitivity/biomarker identification and prediction of cancer drivers
* [clinical intepretations of variants in cancer](https://civic.genome.wustl.edu/#/home)
* [R Wrapper for DGIdb](http://bioconductor.org/packages/devel/bioc/html/rDGIdb.html) Drug-gene interaction database.
* [BioGrid](http://thebiogrid.org/) Welcome to the Biological General Repository for Interaction Datasets
* [The IUPHAR/BPS Guide to PHARMACOLOGY in 2016: towards curated quantitative interactions between 1300 protein targets and 6000 ligands](http://nar.oxfordjournals.org/content/early/2015/10/11/nar.gkv1037.short?rss=1)
* [Public data and open source tools for multi-assay genomic investigation of disease](http://bib.oxfordjournals.org/content/early/2015/10/10/bib.bbv080.long)
* [cancer cell metabolism genes](http://bioinfo.mc.vanderbilt.edu/ccmGDB/index.html)
* [oncogenes and tumor suppressors](https://www.biostars.org/p/15890/) biostar post and [TSgene](http://bioinfo.mc.vanderbilt.edu/TSGene/index.html)  
* [DriverDB: A database for cancer driver gene/mutation](http://ngs.ym.edu.tw/driverdb)
* Interaction of genes: [GENEMANIA](http://genemania.org/)
* [DATA DISCOVERY PLATFORM:Designed for researchers who use, share and collaborate on human genomic data](http://discover.repositive.io/)
* [zenodo: research shared](https://zenodo.org/collection/datasets)
* The NCI's [Genomic Data Commons](https://gdc.nci.nih.gov/) (GDC) provides the cancer research community with a unified data repository that enables data sharing across cancer genomic studies in support of precision medicine. A copy of TCGA and TARGET data? [Data Release Notes](https://gdc-docs.nci.nih.gov/Data/Release_Notes/Data_Release_Notes/?platform=hootsuite)
* [OASIS genomics](http://www.oasis-genomics.org/) from Pfizer. processed data from TCGA, CCLE, GTEx.
* [TCGA alternative splicing](http://bioinformatics.mdanderson.org/TCGASpliceSeq)
* [ISOexpresso](http://wiki.tgilab.org/ISOexpresso/): a web-based platform for isoform-level expression analysis in human cancer
* [omics databse](http://www.omicsdi.org/#/) The Omics Discovery Index (OmicsDI) provides dataset discovery across a heterogeneous, distributed group of Transcriptomics, Genomics, Proteomics and Metabolomics data resources spanning eight repositories in three continents and six organisations, including both open and controlled access data resources. The resource provides a short description of every dataset: accession, description, sample/data protocols biological evidences, publication, etc. Based on these metadata, OmicsDI provides extensive search capabilities, as well as identification of related datasets by metadata and data content where possible. In particular, OmicsDI identifies groups of related, multi-omics datasets across repositories by shared identifiers.
* [How to successfully apply for access to dbGaP](http://blog.repositive.io/how-to-successfully-apply-for-access-to-dbgap/)

### Large data consortium data mining

* [AnnotationHub](http://bioconductor.org/packages/devel/bioc/vignettes/AnnotationHub/inst/doc/AnnotationHub-HOWTO.html#roadmap-epigenomics-project) bioconductor package for TCGA and epigenome roadmap, ENCODE project.  
* [TCGAbiolinks](http://bioconductor.org/packages/devel/bioc/vignettes/TCGAbiolinks/inst/doc/tcgaBiolinks.html) bioconductor package
* [RTCGA bioconductor](http://bioconductor.org/packages/devel/bioc/html/RTCGA.html)
* [f1000 workflow paper TCGA Workflow: Analyze cancer genomics and epigenomics data using Bioconductor packages](http://f1000research.com/articles/5-1542/v1)
* paper [Data mining The Cancer Genome Atlas in the era of precision cancer medicine](http://www.smw.ch/content/smw-2015-14183/)
* [CrossHub](http://sourceforge.net/p/crosshub/): a tool for multi-way analysis of The Cancer Genome Atlas (TCGA) in the context of gene expression regulation mechanisms.
* [Ferret, a User-Friendly Java Tool to Extract Data from the 1000 Genomes Project](http://limousophie35.github.io/Ferret/)
* [EGA:European Genome-phenome Archive](https://www.ebi.ac.uk/ega/datasets)
* [survival curves for TCGA data: a simple web tool](http://www.oncolnc.org/)

### Integrative analysis
* [High-dimensional genomic data bias correction and data integration using MANCIE](http://www.nature.com/ncomms/2016/160413/ncomms11305/full/ncomms11305.html)  correct batch effects for data from different sequencing methods. (RNAseq vs ChIPseq)
* 


### Tutorials
* [PH525x series - Biomedical Data Science](http://genomicsclass.github.io/book/). Learn R and bioconductor.
* [PCA, MDS, k-means, Hierarchical clustering and heatmap](https://rpubs.com/crazyhottommy/PCA_MDS). I wrote it.
* [I wrote on PCA, and heatmaps on Rpub](https://rpubs.com/crazyhottommy)
* A most read for clustering analysis for high-dimentional biological data:[Avoiding common pitfalls when clustering
biological data](http://stke.sciencemag.org/content/9/432/re6)
* [How does gene expression clustering work?](http://www.nature.com/nbt/journal/v23/n12/full/nbt1205-1499.html) A must read for 
clustering.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">See <a href="https://t.co/yxCb85ctL1">https://t.co/yxCb85ctL1</a>: &quot;MDS best choice for preserving outliers,  PCA for variance, &amp; T-SNE for clusters&quot; <a href="https://twitter.com/mikelove">@mikelove</a> <a href="https://twitter.com/AndrewLBeam">@AndrewLBeam</a></p>&mdash; Rileen Sinha (@RileenSinha) <a href="https://twitter.com/RileenSinha/status/768873620521250816">August 25, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

[paper: Outlier Preservation by Dimensionality Reduction Techniques](http://oai.cwi.nl/oai/asset/22628/22628B.pdf)
>"MDS best choice for preserving outliers, PCA for variance, & T-SNE for clusters"



* [Survival analysis of TCGA patients integrating gene expression (RNASeq) data](https://www.biostars.org/p/153013/)
* [Tutorial: Machine Learning For Cancer Classification](https://www.biostars.org/p/85124/). It has four parts. 
* [Learning bash scripting for beginners](http://www.cyberciti.biz/open-source/learning-bash-scripting-for-beginners/)  
* [Bedtools tutorial](http://quinlanlab.org/tutorials/cshl2013/bedtools.html)  
* [Gemini](http://gemini.readthedocs.org/en/latest/#tutorials) explores your vcf, and [slides](https://speakerdeck.com/arq5x).
* [GNU parallel](https://www.biostars.org/p/63816/)  
* [A Tutorial on Principal Component Analysis](http://arxiv.org/abs/1404.1100)  
* [StatQuest: PCA clearly explained](https://www.youtube.com/watch?v=fRiEZWQ-WT8)
* [Computing Workflows for Biologists: A Roadmap](http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1002303)  
* [Best Practices for Scientific Computing](http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1001745)
* [Google's R Style Guide](https://google.github.io/styleguide/Rguide.xml)

### MOOC(Massive Open Online Courses)
* [The Open Source Data Science Masters](http://datasciencemasters.org/)
* [Path to a free self-taught education in Data Science!](https://github.com/open-source-society/data-science)
* [Path to a free self-taught education in Bioinformatics!](https://github.com/open-source-society/bioinformatics)
* [Udacity](https://www.udacity.com/)
* [Coursera](https://www.coursera.org/)
* [edx](https://www.edx.org/)

### git and version control
* [git intro by github](https://github.github.io/on-demand/)
* [paper:A Quick Introduction to Version Control with Git and GitHub](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004668)
* [paper:Ten Simple Rules for Taking Advantage of Git and GitHub](http://journals.plos.org/ploscompbiol/article?id=10.1371%2Fjournal.pcbi.1004947) 
* [software carpentry git novice lesson](http://swcarpentry.github.io/git-novice/)
* [git best practise](https://sethrobertson.github.io/GitBestPractices/)
* [oh shit git!](http://ohshitgit.com/) Git is hard: screwing up is easy, and figuring out how to fix your mistakes is fucking impossible. Git documentation has this chicken and egg problem where you can't search for how to get yourself out of a mess, unless you already know the name of the thing you need to know about in order to fix your problem.
* [How to undo (almost) anything with Git](https://github.com/blog/2019-how-to-undo-almost-anything-with-git)


### Automate your workflow, open science and reproducible research

**STEP 6 is usually missing!**  

![](https://cloud.githubusercontent.com/assets/4106146/19217628/807b5bba-8da5-11e6-8387-5f701d7a9ead.jpg)

The pic was downloaded from http://biobungalow.weebly.com/bio-bungalow-blog/everybody-knows-the-scientific-method

* [Awesome youtube video for reproducible workflow](https://www.youtube.com/watch?v=s3JldKoA0zw&feature=youtu.be)
* [The hard road to reproducibility](http://science.sciencemag.org/content/354/6308/142) commentary on Science Magzine.
* [Make lessons from software carpentry](http://swcarpentry.github.io/make-novice/)
* [STAT545 Automating data analysis pipelines](https://stat545-ubc.github.io/automation00_index.html)
* [Existing Workflow systems](https://github.com/common-workflow-language/common-workflow-language/wiki/Existing-Workflow-systems)
* [Workflow management software for pipeline development in NGS](https://www.biostars.org/p/115745/)
* [pipelines](https://github.com/pditommaso/awesome-pipeline)
* [biostar post:Job Manager to parallelize otherwise consecutive bash scripts](https://www.biostars.org/p/174468/)
* [paper:A review of bioinformatic pipeline frameworks](http://bib.oxfordjournals.org/content/early/2016/03/23/bib.bbw020.long)
* [initial steps toward reproducible research](http://kbroman.org/steps2rr/#TAGC16)
* [JupyterLab: the next generation of the Jupyter Notebook](http://blog.jupyter.org/2016/07/14/jupyter-lab-alpha/)
* [R notebook](http://data-steve.github.io/setting-up-r-notebook/)
* [BEAKER THE DATA SCIENTIST'S LABORATORY](http://beakernotebook.com/)
* A video by  Dr.Keith A. Baggerly from MD Anderson [The Importance of Reproducible Research in High-Throughput Biology](https://www.youtube.com/watch?v=7gYIs7uYbMo)  very interesting, and Keith is really a fun guy!
* [paper: Ten Simple Rules for Reproducible Computational Research](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1003285)
* [open-research](https://github.com/svaksha/aksh/blob/master/open-research.md#arr)
* [Good Enough Practices in Scientific Computing](http://arxiv.org/abs/1609.00037) We present a set of computing tools and techniques that every researcher can and should adopt. These recommendations synthesize inspiration from our own work, from the experiences of the thousands of people who have taken part in Software Carpentry and Data Carpentry workshops over the past six years, and from a variety of other guides. Unlike some other guides, our recommendations are aimed specifically at people who are new to research computing.  **Well worth reading!**
* [A Quick Guide to Organizing Computational Biology Projects](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000424) A must read for computational biologists!


I will try snakemake...

* **Have you ever had problem to reuse one of your own published figures due to copyright of the journal?**
Here is the [solution](https://storify.com/LorenaABarba/reactions-to-my-tip-on-how-i-use-figshare)! from @LorenaABarba

>As an early adopter of the Figshare repository, I came up with a strategy that serves both our open-science and our reproducibility goals, and also helps with this problem: for the main results in any new paper, we would share the data, plotting script and figure under a CC-BY license, by first uploading them to Figshare. 

### Survival curve

* [Survival plots have never been so informative: survminer package](http://r-addict.com/2016/05/23/Informative-Survival-Plots.html)
* posts for survival analysis:  
** [Survival Analysis - 1](http://justanotherdatablog.blogspot.com/2015/08/survival-analysis-1.html)  KM estimator  
** [Survival Analysis - 2](http://justanotherdatablog.blogspot.com/2015/08/survival-analysis-2.html)  Cox's proportional hazards model  
** [Overall Survival Curves for TCGA and Tothill by RD Status](http://bioinformatics.mdanderson.org/Supplements/ResidualDisease/Reports/osCurves.html)  
** [Survival analysis of TCGA patients integrating gene expression (RNASeq) data](https://www.biostars.org/p/153013/)  

### Organize research for a group
* [slack](https://slack.com/):A messaging app for teams.
* [Ryver](http://www.ryver.com/ryver-vs-slack/).
* [Trello](https://trello.com/) lets you work more collaboratively and get more done.


### Clustering
* [densityCut](http://m.bioinformatics.oxfordjournals.org/content/early/2016/04/23/bioinformatics.btw227.short?rss=1): an efficient and versatile topological approach for automatic clustering of biological data

### CRISPR related 
* [CRISPR GENOME EDITING MADE EASY](https://www.deskgen.com/landing/)
* [CRISPR design from Japan](http://crispr.dbcls.jp/)
* [CRISPResso](http://crispresso.rocks/):Analysis of CRISPR-Cas9 genome editing outcomes from deep sequencing data
* [CRISPR-DO](http://cistrome.org/crispr/): A whole genome CRISPR designer and optimizer in human and mouse
* [CCTop](http://crispr.cos.uni-heidelberg.de/) - CRISPR/Cas9 target online predictor
* [DESKGEN](https://horizon.deskgen.com/landing/#/)
* [Genome-wide Unbiased Identifications of DSBs Evaluated by Sequencing (GUIDE-seq) is a novel method the Joung lab has developed to identify the off-target sites of CRISPR-Cas RNA-guided Nucleases](http://www.jounglab.org/guideseq)
* [WTSI Genome Editing (WGE) is a website that provides tools to aid with genome editing of human and mouse genomes](http://www.sanger.ac.uk/htgt/wge/)
