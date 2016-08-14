If you ever wants to use R on the command line, now you have several opitions.

### [litter](https://github.com/eddelbuettel/littler)

I wanted to use `littler` for a long time on my mac, but was intimidated by the complex installation process. Since version `0.3.0`, it is on CRAN,and can be installed within R console or Rstudio by:

```r
> install.packages("littler")
Installing package into ‘/Users/mtang1/Library/R/3.3/library’
(as ‘lib’ is unspecified)
trying URL 'https://cran.rstudio.com/bin/macosx/mavericks/contrib/3.3/littler_0.3.1.tgz'
Content type 'application/x-gzip' length 50351 bytes (49 KB)
==================================================
downloaded 49 KB


The downloaded binary packages are in
	/var/folders/79/x06wz9v560q10gw881n9c_z0x7m0vl/T//RtmphlFEcc/downloaded_packages
> library(littler)
The littler package provides 'r' as a binary.
See 'vignette("littler-examples") for some illustrations.
On OS X, 'r' and 'R' are the same so 'lr' is an alternate name for littler.
You could link to the 'r' binary installed in
'/Users/mtang1/Library/R/3.3/library/littler/bin/r'
as '/usr/local/bin/lr' in order to use 'lr' for scripting.
```
you just need to make a symbolic link by:

```bash
ln -s /Users/mtang1/Library/R/3.3/library/littler/bin/r  /usr/local/bin/lr
```
Now you can start to use R as `lr` at the command line:

```bash
lr -h

Usage: r [options] [-|file]

Launch GNU R to execute the R commands supplied in the specified file, or
from stdin if '-' is used. Suitable for so-called shebang '#!/'-line scripts.

Options:
  -h, --help           Give this help list
      --usage          Give a short usage message
  -V, --version        Show the version number
  -v, --vanilla        Pass the '--vanilla' option to R
  -t, --rtemp          Use per-session temporary directory as R does
  -i, --interactive    Let interactive() return 'true' rather than 'false'
  -q, --quick          Skip autoload / delayed assign of default libraries
  -p, --verbose        Print the value of expressions to the console
  -l, --packages list  Load the R packages from the comma-separated 'list'
  -d, --datastdin      Prepend command to load 'X' as csv from stdin
  -L, --libpath dir    Add directory to library path via '.libPaths(dir)'
  -e, --eval expr      Let R evaluate 'expr'
```
Go to `littler`'s page for [more usage examples](http://dirk.eddelbuettel.com/code/littler.html).

From [this issue](https://github.com/eddelbuettel/littler/issues/11) on github, I found one can install littler on mac by `brew` (this is really should be the way to manage software installation on mac)

```bash
brew tap homebrew/science
brew install littler
```
It will be installed as `littler` to avoid confusions.   
**NOTE** I tried `brew install` as well, but it seems to be isolated with my installed R packages as it complains `dplyr` is not installed when I do `littler -l dplyr,tidyr`.

### [`rscl`](https://github.com/jeroenjanssens/rscl)  and [`Rio`](https://github.com/jeroenjanssens/data-science-at-the-command-line/blob/master/tools/Rio). 

Both are from the author of `Data science at the command line`: Jeroen Janssens.

```r
if (packageVersion("devtools") < 1.6) {
  install.packages("devtools")
}
devtools::install_github("jeroenjanssens/rscl")

rscl::setup()
# If you want to invoke `rscl` from anywhere on your filesystem, add the line
# below to ~/.bashrc, ~/.zshrc, or whathever file your shell sources at startup.
export PATH="$PATH:/Users/mtang1/Library/R/3.3/library/rscl/bin"
> 
```
on command line:  

```bash
ln -s /Users/mtang1/Library/R/3.3/library/rscl/bin/
```
when I execute `rscl`, I got an segment fault error. I opened [an issue](https://github.com/jeroenjanssens/rscl/issues/4) on github.

For usage of `Rio`, see my previous blog post: [csvkit to manipulate csv at command line, Rio to interact with R at command line](http://crazyhottommy.blogspot.com/2014/11/csvkit-to-manipulate-csv-at-command.html)
