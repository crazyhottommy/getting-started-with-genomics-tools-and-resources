### Linux commands
* [A Bioinformatician's UNIX Toolbox](http://lh3lh3.users.sourceforge.net/biounix.shtml#xargs) from Heng Li  
* [Linux command line exercises for NGS data processing](http://userweb.eng.gla.ac.uk/umer.ijaz/bioinformatics/linux.html)  
* [command line bootcamp](http://rik.smith-unna.com/command_line_bootcamp/?id=rca84m6nsz6c9ngnugt8uayvi) teaches you unix command step by step
* [bash one-liners for bioinformatics](https://github.com/crazyhottommy/oneliners)  
* [some of my bash one-liner collections](https://github.com/crazyhottommy/scripts-general-use/blob/master/Shell/bioinformatics_one_liner.md)
* [Use the Unofficial Bash Strict Mode (Unless You Looove Debugging)](http://redsymbol.net/articles/unofficial-bash-strict-mode/)
* [Defensive BASH Programming](http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming) very good read for bash programming.
* [Bash by example](https://www.ibm.com/developerworks/library/l-bash/)
* [NGS Advanced Beginner/Intermediate Shell](https://github.com/ngs-docs/2016-adv-begin-shell-genomics)
* Commonly used commands for PBS scheduler:[Monitoring and Managing Your Job](https://www.osc.edu/supercomputing/batch-processing-at-osc/monitoring-and-managing-your-job)
* people say awk is not part of bioinformats :) Still very useful parsing plain text files. [Steve's Awk Academy](http://troubleshooters.com/codecorn/awk/index.htm)

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

### Do not give me excel files!
* [convert xlsx to csv: xlsx2csv](https://github.com/dilshod/xlsx2csv)
* [csvkit](http://csvkit.readthedocs.io/en/latest/index.html#)
* [GNU datamash](https://www.gnu.org/software/datamash/)

### parallelization 

Using these tool will greatly improve your working efficiency and get rid of most of your `for loops`.  
1. [xargs](http://www.cyberciti.biz/faq/linux-unix-bsd-xargs-construct-argument-lists-utility/)  
2. [GNU parallel](https://www.gnu.org/software/parallel/). one of my post [here](http://crazyhottommy.blogspot.com/2016/03/the-most-powerful-uniux-commands-i.html)  
3. [gxargs](https://github.com/brentp/gargs) by Brent Pedersen. Written in GO.  

#### R packages for data wrangling, tidying and visualizing.  

* [biobroom](https://www.bioconductor.org/packages/release/bioc/html/biobroom.html):Turn Bioconductor objects into tidy data frames  
* [readr](https://github.com/hadley/readr)  
* [tidyr](https://github.com/hadley/tidyr)  
* [dplry](https://github.com/hadley/dplyr)  
* [ggplot2](https://github.com/hadley/ggplot2)
* [ggplot2 tips](http://t-redactyl.io/tag/ggplot2.html)
* [A List of ggplot2 extensions](https://www.ggplot2-exts.org/)
* [htmlwidgets for R](http://www.htmlwidgets.org/showcase_d3heatmap.html) including `d3heatmap` for interactive heatmaps.
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

### visualization in general

* [Nature Methods point of view data visulization](http://blogs.nature.com/methagora/2013/07/data-visualization-points-of-view.html)

### python tips and tools

* [30 Python Language Features and Tricks You May Not Know About](http://sahandsaba.com/thirty-python-language-features-and-tricks-you-may-not-know.html#id1)
* [intermediatePython](https://github.com/crazyhottommy/intermediatePython)
* [The Hitchhiker’s Guide to Python!](http://docs.python-guide.org/en/latest/)
* [Python 3 for Scientists](http://python-3-for-scientists.readthedocs.io/en/latest/)

### Papers
* 2016 review [Coming of age: ten years of next-generation sequencing technologies](http://www.nature.com/nrg/journal/v17/n6/full/nrg.2016.49.html)

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
* The NCI's [Genomic Data Commons](https://gdc.nci.nih.gov/) (GDC) provides the cancer research community with a unified data repository that enables data sharing across cancer genomic studies in support of precision medicine. A copy of TCGA and TARGET data?
* [OASIS genomics](http://www.oasis-genomics.org/) from Pfizer. processed data from TCGA, CCLE, GTEx.
* [TCGA alternative splicing](http://bioinformatics.mdanderson.org/TCGASpliceSeq)
* [How to successfully apply for access to dbGaP](http://blog.repositive.io/how-to-successfully-apply-for-access-to-dbgap/)

### Large data consortium data mining

* [AnnotationHub](http://bioconductor.org/packages/devel/bioc/vignettes/AnnotationHub/inst/doc/AnnotationHub-HOWTO.html#roadmap-epigenomics-project) bioconductor package for TCGA and epigenome roadmap, ENCODE project.  
* [TCGAbiolinks](http://bioconductor.org/packages/devel/bioc/vignettes/TCGAbiolinks/inst/doc/tcgaBiolinks.html) bioconductor package
* [RTCGA bioconductor](http://bioconductor.org/packages/devel/bioc/html/RTCGA.html)
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
* A most read for clustering analysis for high-dimentional biological data:[Avoiding common pitfalls when clustering
biological data](http://stke.sciencemag.org/content/9/432/re6)
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
* [A collection of python courses online](http://bafflednerd.com/learn-python-online/)
* [The Open Source Data Science Masters](http://datasciencemasters.org/)

### git and version control

* [paper:A Quick Introduction to Version Control with Git and GitHub](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004668)
* [paper:Ten Simple Rules for Taking Advantage of Git and GitHub](http://journals.plos.org/ploscompbiol/article?id=10.1371%2Fjournal.pcbi.1004947) 
* [software carpentry git novice lesson](http://swcarpentry.github.io/git-novice/)


### Automate your workflow and reproducible research
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

I will try snakemake...

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
