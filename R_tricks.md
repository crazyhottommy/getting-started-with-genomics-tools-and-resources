
### add a unique id for rows with the same values on columns 

http://stackoverflow.com/questions/41231209/r-define-distinct-pattern-from-values-of-multiple-variables
```r
dplyr::group_indices()

data.frame(x=c(0,0,0,1,1,1), y=c(0,0,1,0,1,1))

group_indices(df, x, y)

df %>% mutate(pattern = group_indices_(df, .dots = c('x', 'y')))

```

### alternative to nested `ifelse`:
```r
library(dplyr)
case_when

cars %>% as_tibble %>% mutate(case_code = case_when(
                              speed == 4 & dist == 2 ~ "this",
                              dist > 6 & dist == 10 ~ "is",
                              speed >=10 & dist >= 18 ~ "awesome"))
                   

```

### choose the max value of a group

```r
df %>% group_by(A, B) %>% top_n(n=1, wt= C)
df %>% group_by(A,B) %>% slice(which.max(C))
df %>% group_by(A, B) %>% filter(value == max(C)) 
```
### filter by group
```r
df %>% group_by(A,B) %>% filter(all(C>10))
df %>% group_by(A,B) %>% filter(any(C>10))
```

### first and last row in a group
```r
df %>% arrange(stopSequence) %>% group_by(id) %>% slice(c(1,n()))
```
### change all the factor columns to characters
```r
library(purrr)
library(dplyr)
bob %>% map_if(is.factor, as.character)

bob %>% mutate_if(is.factor, as.character)
```
### cut groups on the fly in ggplot2

```r
p <- ggplot(diamonds, aes(x = carat, y = price))

# Use cut_interval
p + geom_boxplot(aes(group = cut_interval(carat, n=10)))

# Use cut_number
p + geom_boxplot(aes(group = cut_number(carat, n =10)))

# Use cut_width
p + geom_boxplot(aes(group = cut_width(carat, width = 0.25)))
```

### dplyr cut_width

```r
diamonds %>% count(cut_width(carat, 0.5))
```
### reorder boxplot by median

```r
ggplot(mpg) + geom_boxplot(aes(x = reoder(class, hwy, FUN = median), y = hwy)) 

```
### weight box plot and violin plot by number of observations
```r
ggplot(diamonds, aes(x = cut, y = price)) + geom_boxplot(varwidth = TRUE)

library(dplyr)
mammals2 <- mammals %>%
  group_by(vore) %>%
  mutate(n = n()/nrow(mammals))
  
ggplot(mammals2, aes(x = vore, y = sleep_total, fill = vore)) +
  geom_violin(aes(weight = n), col = NA)
```

### Reorder rows using custom order

```r
library(tibble)
df<- tibble(category=LETTERS[1:3], b=1:3)
x<- c("C", "A", "B")

# reorder
df %>% slice(match(x, category))
# A tibble: 3 × 2
  category     b
     <chr> <int>
1        C     3
2        A     1
3        B     2

```

https://stackoverflow.com/questions/46129322/arranging-rows-in-custom-order-using-dplyr


```{r}
> df<- data.frame(num = c(1,3,4,5,3,2), type = c("A", "B", "C", "C", "A", "B"))
> df
  num type
1   1    A
2   3    B
3   4    C
4   5    C
5   3    A
6   2    B

> df %>% arrange(match(type, c("C", "A", "B")), desc(num))
  num type
1   5    C
2   4    C
3   3    A
4   1    A
5   3    B
6   2    B
```

### filter out groups of rows by dplyr if a column in a group are all smaller than a number

```r
df %>% group_by(A,B) %>% filter(all(C >10)) 
```

### ggplot geom_density()

>The default combined density plot extends the range of all values to the total extent of the entire dataset, which may be a bit confusing. In the fourth plot, adjust for this by setting trim = TRUE inside `geom_density()`. However, be cautious. Since the distributions are cut off at the extreme ends, the area under the curve technically is not equal to one anymore.

### parallel coordinate plot

```r
require(GGally)
ggparcoord(iris, columns = 1:4, groupColumn = 5, scale = "globalminmax", order = "anyClass", alphaLines = 0.4) 
```
![](https://cloud.githubusercontent.com/assets/4106146/21956921/a139fc92-da50-11e6-9630-f56805ebd5d3.png)

### plot MDS with ggfortify

As you can probably imagine, distance matrices (class dist) contain the measured distance between all pair-wise combinations of many points. For example, the eurodist dataset contains the distances between major European cities. dist objects lend themselves well to `ggfortify::autoplot()`.

The `stats::cmdscale()` function performs Classical Multi-Dimensional Scaling and returns point coodinates as a matrix. Although autoplot will work on this object, it will produce a heatmap, and not a scatter plot. However, if either `eig = TRUE`, `add = TRUE` or `x.ret = TRUE` is specified, stats::cmdscale() will return a list instead of matrix. In these cases, `ggfortify::autoplot` can deal with the output. Details on these arguments can be found in the docs (?cmdscale).

```r
# ggfortify and eurodist are available

# Autoplot + ggplot2 tweaking
autoplot(eurodist) + 
labs( x = "", y = "") + 
coord_fixed() +
theme(axis.text.x = element_text(angle = 90, hjust =1, vjust = 0.5))

# Autoplot of MDS
autoplot(cmdscale(eurodist, eig = TRUE), label = TRUE, label.size =3, size = 0)

```

### build multiple plots
also check `purrr`, Hadely has not used `plyr` for long time. ref...twitter
```r
library(plyr)
myplots<- dlplyr(mtcars, .(cyl), function(df){
        ggplot(df, aes(mpg, wt)) +
                geom_point() +
                xlim(range(mtcars$mpg)) +
                ylim(range(mtcars$wt)) +
                ggtilte(paste(df$cyl[1], "cylinders"))})
# by position                
myplots[[2]]

# by name
myplots[["4"]]
library(gridExtra)

grid.arrange(myplots[[1]], myplots[[2]], ncol = 2)
do.call(grid.arrange, myplots)

```

### plot k-means result with ggfortify

```r
library(ggfortify)
# perform clustering
iris_k<- kmeans(iris[-5], center = 3)

# autplot: coloring according to cluster
autoplot(iris_k, data = iris, frame = TRUE)

# autoplot: coloring according to species
autoplot(iris_k, data = iris, frame = TRUE, col = "Species")

```
### join, filter multiple datasets

```r
df1 %>% left_join(df2) %>% left_join(df3)....

library(purrr)

tables<- list(df1,df2,df3)
reduce(tables, left_join, by = "key")

list(more_artists, more_bands, supergroups) %>% 
  # Return rows of more_artists in all three datasets
  reduce(semi_join, by = c("first", "last"))
```
### I need more color for my ggplot2
read http://novyden.blogspot.com/2013/09/how-to-expand-color-palette-with-ggplot.html

```r
colorRampPalette(brewer.pal(9, "Set1"))(26)
 [1] "#E41A1C" "#AC3A4D" "#755A7F" "#3D7AB1" "#3D8B99" "#449B75" "#4BAB52" "#5F975F" "#77787B" "#8F5998"
[11] "#AC5782" "#CD674E" "#EE771A" "#FF9308" "#FFBC18" "#FFE528" "#F4EA31" "#D7B42E" "#BB7E2A" "#AC5934"
[21] "#C66764" "#E07494" "#F381BD" "#D589B1" "#B791A5" "#999999"

```
### balloon plot alternative to heatmap
read here https://datascience.blog.wzb.eu/2017/01/24/creating-a-balloon-plot-as-alternative-to-a-heat-map-with-ggplot2/

![](https://cloud.githubusercontent.com/assets/4106146/22408099/80c69cd8-e638-11e6-8acc-4964031eadd9.png)
```r
# Create a "balloon plot" as alternative to a heatmap with ggplot2
# 
# January 2017
# Author: Markus Konrad <markus.konrad@wzb.eu>, WZB Berlin Social Science Center

library(dplyr)
library(tidyr)
library(ggplot2)

# define the variables that will be displayed in the columns
vars <- c('awake', 'sleep_total', 'sleep_rem')

# prepare the data: we use the "msleep" dataset which comes with ggplot2
df <- msleep[!is.na(msleep$vore), c('name', 'vore', vars)] %>%  # only select the columns we need from the msleep dataset
  group_by(vore) %>% sample_n(5) %>% ungroup() %>%              # select 5 random rows from each "vore" group as subset
  gather(key = variable, value = value, -name, -vore) %>%       # make a long table format: gather columns in rows
  filter(!is.na(value)) %>%                                     # remove rows with NA-values -> those will be empty spots in the plot
  arrange(vore, name)                                           # order by vore and name

# add a "row" column which will be the y position in the plot: group by vore and name, then set "row" as group index
df <- df %>% mutate(row = group_indices_(df, .dots=c('vore', 'name')))
# add a "col" column which will be the x position in the plot: group by variable, then set "col" as group index
df <- df %>% mutate(col = group_indices_(df, .dots=c('variable')))

# get character vector of variable names for the x axis. the order is important, hence arrange(col)!
vars_x_axis <- c(df %>% arrange(col) %>% select(variable) %>% distinct())$variable
# get character vector of observation names for the y axis. again, the order is important but "df" is already ordered
names_y_axis <- c(df %>% group_by(row) %>% distinct(name) %>% ungroup() %>% select(name))$name

# now plot
# make color dependent on vore, size and alpha dependent on value
# x and y must be set as factor() otherwise scale_x/y_discrete() won't work
ggplot(df, aes(x=factor(col), y=factor(row), color=vore, size=value, alpha=value)) +
  geom_point() +    # plot as points
  geom_text(aes(label=value, x=col + 0.25), alpha=1.0, size=3) +   # display the value next to the "balloons"
  scale_alpha_continuous(range=c(0.3, 0.7)) +
  scale_size_area(max_size = 5) +
  scale_x_discrete(breaks=1:length(vars_x_axis), labels=vars_x_axis, position='top') +   # set the labels on the X axis
  scale_y_discrete(breaks=1:length(names_y_axis), labels=names_y_axis) +                 # set the labels on the Y axis
  theme_bw() +
  theme(axis.line = element_blank(),            # disable axis lines
        axis.title = element_blank(),           # disable axis titles
        panel.border = element_blank(),         # disable panel border
        panel.grid.major.x = element_blank(),   # disable lines in grid on X-axis
        panel.grid.minor.x = element_blank())   # disable lines in grid on X-axis
```

### write a list of dataframe to files.

```r
df_list<- split(df, df$A)
sapply(names(df_list), function (x) write.table(df_list[[x]], file=paste(x, "txt", sep=".")))
```

### read in a list of data frames from the current directory 

```r
files<- as.list(dir(".", pattern= ".tsv"))

## need to add the file name into a column
datlist <- lapply(mix.files, function(f) {
        dat = read.table(f, header =T, sep ="\t", quote = "\"")
        dat$sample = gsub(".tsv", "", f)
        return(dat)
})

data<- do.call(rbind, datlist)
## or use dplyr: bind_rows(datlist, .id = "sample")

## if each file has a common column, e.g. RNAseq HTSeq counts for many samples, and you want to make a big dataframe with first column
## is the gene-id and columns of raw counts
CCLE_counts<- reduce(datlist, left_join, by = "GeneID")
```

or https://github.com/vsbuffalo/devnotes/wiki/Data-Analysis-Patterns by Vince Buffalo.

```r
### example setup:
DIR <- 'path/to/data' # change to directory you can write files to.
# filenames to make example work:
files <- c('sampleA_rep01.tsv', 'sampleA_rep02.tsv','sampleB_rep01.tsv', 
           'sampleB_rep02.tsv', 'sampleC_rep01.tsv', 'sampleC_rep02.tsv')

# write test files for example (iris a bunch of times)
walk(files, ~ write_tsv(iris, file.path(DIR, .)))

### Pattern:
# grab all files programmatically: 
input_files <- list.files(DIR, 
                          pattern='sample.*\\.tsv', full.names=TRUE)

# data loading pattern:
all_data <- tibble(file=input_files) %>% 
   # read data in (note: in general, best to 
   # pass col_names and col_types to map)
   mutate(data=map(file, read_tsv)) %>% 
   # get the file basename (no path); if 
   # your metadata is in the path, change accordingly!
   mutate(basename=basename(file)) %>% 
   # extract out the metadata from the base filename
   extract(basename, into=c('sample', 'rep'), 
           regex='sample([^_]+)_rep([^_]+)\\.tsv') %>% 
   unnest(data)  # optional, depends on what you need.
```
or use `purrr::map_df`

```{r}
f <- list.files(
  "my_folder",
   pattern = "*.csv",
   full.names = TRUE)

d <- purrr::map_df(f, readr::read_csv, .id = "id")
```
### gather multiple columns
read http://stackoverflow.com/questions/41880796/grouped-multicolumn-gather-with-dplyr-tidyr-purrr
```r
have
#> # A tibble: 4 × 8
#>    gene sample genotype1 genotype2 genotype3 freq1 freq2 freq3
#>   <chr>  <chr>     <chr>     <chr>     <chr> <dbl> <dbl> <dbl>
#> 1    gX     s1        AA        AC        CC   0.8  0.15  0.05
#> 2    gX     s2        AA        AC        CC   0.9  0.10  0.00
#> 3    gY     s1        GG        GT        TT   0.7  0.20  0.10
#> 4    gY     s2        GG        GT        TT   0.6  0.35  0.05

to

want
#> # A tibble: 12 × 4
#>     gene sample genotype  freq
#>    <chr>  <chr>    <chr> <dbl>
#> 1     gX     s1       AA  0.80
#> 2     gX     s1       AC  0.15
#> 3     gX     s1       CC  0.05
#> 4     gX     s2       AA  0.90
#> 5     gX     s2       AC  0.10
#> 6     gX     s2       CC  0.00
#> 7     gY     s1       GG  0.70
#> 8     gY     s1       GT  0.20
#> 9     gY     s1       TT  0.10
#> 10    gY     s2       GG  0.60
#> 11    gY     s2       GT  0.35
#> 12    gY     s2       TT  0.05

library(sjmisc)
to_long(have, keys = "genos", values = c("genotype", "freq"),
       c("genotype1", "genotype2", "genotype3"),
       c("freq1", "freq2", "freq3"))

##  A tibble: 12 × 5
##     gene sample     genos genotype  freq
##    <chr>  <chr>     <chr>    <chr> <dbl>
## 1     gX     s1 genotype1       AA  0.80
## 2     gX     s2 genotype1       AA  0.90
## 3     gY     s1 genotype1       GG  0.70
## 4     gY     s2 genotype1       GG  0.60
## 5     gX     s1 genotype2       AC  0.15
## 6     gX     s2 genotype2       AC  0.10
## 7     gY     s1 genotype2       GT  0.20
## 8     gY     s2 genotype2       GT  0.35
## 9     gX     s1 genotype3       CC  0.05
## 10    gX     s2 genotype3       CC  0.00
## 11    gY     s1 genotype3       TT  0.10
## 12    gY     s2 genotype3       TT  0.05

library(data.table)
melt(setDT(have), id = 1:2, measure = patterns("genotype", "freq"))

```

### mutate_at()

```r
> iris %>% as_tibble()
# A tibble: 150 × 5
   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
          <dbl>       <dbl>        <dbl>       <dbl>  <fctr>
1           5.1         3.5          1.4         0.2  setosa
2           4.9         3.0          1.4         0.2  setosa
3           4.7         3.2          1.3         0.2  setosa
4           4.6         3.1          1.5         0.2  setosa
5           5.0         3.6          1.4         0.2  setosa
6           5.4         3.9          1.7         0.4  setosa
7           4.6         3.4          1.4         0.3  setosa
8           5.0         3.4          1.5         0.2  setosa
9           4.4         2.9          1.4         0.2  setosa
10          4.9         3.1          1.5         0.1  setosa
# ... with 140 more rows

# convert columns to characters
>iris %>% as_tibble() %>% mutate_at(vars(Sepal.Length:Petal.Width), as.character) %>% head()
# A tibble: 6 × 5
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
         <chr>       <chr>        <chr>       <chr>  <fctr>
1          5.1         3.5          1.4         0.2  setosa
2          4.9           3          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
4          4.6         3.1          1.5         0.2  setosa
5            5         3.6          1.4         0.2  setosa
6          5.4         3.9          1.7         0.4  setosa

```

### mutate_if()

convert character columns back to double 
```r
iris %>% as_tibble() %>% mutate_at(vars(Sepal.Length:Petal.Width), as.character) %>% mutate_if(is.character, as.double)
# A tibble: 150 × 5
   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
          <dbl>       <dbl>        <dbl>       <dbl>  <fctr>
1           5.1         3.5          1.4         0.2  setosa
2           4.9         3.0          1.4         0.2  setosa
3           4.7         3.2          1.3         0.2  setosa
4           4.6         3.1          1.5         0.2  setosa
5           5.0         3.6          1.4         0.2  setosa
6           5.4         3.9          1.7         0.4  setosa
7           4.6         3.4          1.4         0.3  setosa
8           5.0         3.4          1.5         0.2  setosa
9           4.4         2.9          1.4         0.2  setosa
10          4.9         3.1          1.5         0.1  setosa
# ... with 140 more rows

```

### diff, lag and lead

```r
# diff minus the previous number in sequence
> a<- c(1,2,5,7,9,14)
> diff(a)
[1] 1 3 2 2 5

## the long way
> a
[1]  1  2  5  7  9 14
> lag(a, 1)
[1] NA  1  2  5  7  9
> a - lag(a,1)
[1] NA  1  3  2  2  5
```
### Window functions and grouped mutate/filter

https://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html
>A window function is a variation on an aggregation function. Where an aggregation function, like sum() and mean(), takes n inputs and return a single value, a window function returns n values. The output of a window function depends on all its input values, so window functions don’t include functions that work element-wise, like + or round(). Window functions include variations on aggregate functions, like cumsum() and cummean(), functions for ranking and ordering, like rank(), and functions for taking offsets, like lead() and lag().

### move variables to the front of the dataframe with the everything() helper function

```r
select(flights, time_hour, air_time, everything())
```

### plot a table together with a ggplot2 figure
see http://www.magesblog.com/2015/04/plotting-tables-alsongside-charts-in-r.html

```r
# Create some sample data
CV_1 <- 0.2
CV_2 <- 0.3
Mean <- 65
sigma_1 <- sqrt(log(1 + CV_1^2))
mu_1 <- log(Mean) - sigma_1^2 / 2
sigma_2 <- sqrt(log(1 + CV_2^2))
mu_2 <- log(Mean) - sigma_2^2 / 2
q <- c(0.25, 0.5, 0.75, 0.9, 0.95) 
SummaryTable <- data.frame(
  Quantile=paste0(100*q,"%ile"), 
  Loss_1=round(qlnorm(q, mu_1, sigma_1),1),
  Loss_2=round(qlnorm(q, mu_2, sigma_2),1)
  )
# Create a plot 
library(ggplot2)
plt <- ggplot(data.frame(x=c(20, 150)), aes(x)) + 
  stat_function(fun=function(x) dlnorm(x, mu_1, sigma_1), 
                aes(colour="CV_1")) + 
  stat_function(fun=function(x) dlnorm(x, mu_2, sigma_2), 
                aes(colour="CV_2")) +
  scale_colour_discrete(name = "CV", 
                        labels=c(expression(CV[1]), expression(CV[2]))) +
  xlab("Loss") +  
  ylab("Density") +
  ggtitle(paste0("Two log-normal distributions with same mean of ",
                 Mean,", but different CVs")) 
# Create a table plot
library(gridExtra)
names(SummaryTable) <- c("Quantile", 
              expression(Loss(CV[1])),
              expression(Loss(CV[2])))
# Set theme to allow for plotmath expressions
tt <- ttheme_default(colhead=list(fg_params = list(parse=TRUE)))
tbl <- tableGrob(SummaryTable, rows=NULL, theme=tt)
# Plot chart and table into one object
grid.arrange(plt, tbl,
             nrow=2,
             as.table=TRUE,
             heights=c(3,1))
```

![](https://cloud.githubusercontent.com/assets/4106146/25259762/abebc1f8-260d-11e7-9c50-f983dfd51dbf.png)

### remove columns with all NAs

```r
... %>%
  select_if(~ !all(is.na(.)))
  
 # OR equivalent
  select_if(function(.) !all(is.na(.)))
  
 janitor::remove_empty_cols()

```
### replace all NAs with 0 in a df

https://stackoverflow.com/questions/45576805/how-to-replace-all-na-in-a-dataframe-using-tidyrreplace-na

```r

df %>% replace(is.na(.), 0)
df %>% %>% mutate_all(coalesce, 0)
```

### add a new column with rank based on two or more columns of a df

```r
df %>% arrange(var1, var2) %>% mutate(my_rank = 1: n())

df %>% arrange(var1, var2) %>% mutate(my_rank = row_number())
```

### less know useful functions

https://twitter.com/robinson_es/status/953432465514876928
```r
rlang::set_names() = purrr::set_names() 

rlang::set_names(), tibble::rowid_to_column(), modelr::seq_range(), the .data pronoun, purrr::safely(), dplyr::pull(), stringr::str_replace_all() with a named vector

enframe, deframe, fct_reorder, fct_reorder2
```
### ggplot boxplot with whiskers

https://stats.stackexchange.com/questions/8137/how-to-add-horizontal-lines-to-ggplot2-boxplot

```r
bp <- ggplot(iris, aes(factor(Species), Sepal.Width, fill = Species)) +  stat_boxplot(geom ='errorbar')
bp + geom_boxplot()
```

### raincloud plots

https://micahallen.org/blog-neuroconscience/

```r
library(readr)
library(tidyr)
library(ggplot2)
library(Hmisc)
library(plyr)
library(RColorBrewer)
library(reshape2)

source("https://gist.githubusercontent.com/benmarwick/2a1bb0133ff568cbe28d/raw/fb53bd97121f7f9ce947837ef1a4c65a73bffb3f/geom_flat_violin.R")

my_data<-read.csv(url("https://data.bris.ac.uk/datasets/112g2vkxomjoo1l26vjmvnlexj/2016.08.14_AnxietyPaper_Data%20Sheet.csv"))

head(X)
library(reshape2)
my_datal <- melt(my_data, id.vars = c("Participant"), measure.vars = c("AngerUH", "DisgustUH", "FearUH", "HappyUH"), variable.name = "EmotionCondition", value.name = "Sensitivity")

head(my_datal)

raincloud_theme = theme(
text = element_text(size = 10),
axis.title.x = element_text(size = 16),
axis.title.y = element_text(size = 16),
axis.text = element_text(size = 14),
axis.text.x = element_text(angle = 45, vjust = 0.5),
legend.title=element_text(size=16),
legend.text=element_text(size=16),
legend.position = "right",
plot.title = element_text(lineheight=.8, face="bold", size = 16),
panel.border = element_blank(),
panel.grid.minor = element_blank(),
panel.grid.major = element_blank(),
axis.line.x = element_line(colour = 'black', size=0.5, linetype='solid'),
axis.line.y = element_line(colour = 'black', size=0.5, linetype='solid'))

lb <- function(x) mean(x) - sd(x)
ub <- function(x) mean(x) + sd(x)

sumld<- ddply(my_datal, ~EmotionCondition, summarise, mean = mean(Sensitivity), median = median(Sensitivity), lower = lb(Sensitivity), upper = ub(Sensitivity))

head(sumld)

g <- ggplot(data = my_datal, aes(y = Sensitivity, x = EmotionCondition, fill = EmotionCondition)) +
geom_flat_violin(position = position_nudge(x = .2, y = 0), alpha = .8) +
geom_point(aes(y = Sensitivity, color = EmotionCondition), position = position_jitter(width = .15), size = .5, alpha = 0.8) +
geom_boxplot(width = .1, guides = FALSE, outlier.shape = NA, alpha = 0.5) +
expand_limits(x = 5.25) +
guides(fill = FALSE) +
guides(color = FALSE) +
scale_color_brewer(palette = "Spectral") +
scale_fill_brewer(palette = "Spectral") +
# coord_flip() +
theme_bw() +
raincloud_theme

g

```

### ggrepel label points

```r
data<- data.frame( 
        x = 1:10,
        y = rnorm(10),
        name = c("Apple", "Banana", "Kiwi", "Orange", "Watermelon", 
                 "Grapes", "Pear", "Cantelope", "Tomato", "Satusma")
)

my_data<- mutate(data, name_poor = case_when(
        y < 0 ~ name,
        TRUE ~ ""
))

ggplot(my_data, aes(x = x, y = y)) + 
               geom_point(size = 5) +
               geom_text_repel(aes(label = name_poor), point.padding = 2)
```
### convert a tidy df to a nested json

https://stackoverflow.com/questions/50477156/convert-a-tidy-table-to-deeply-nested-list-using-r-and-tidyverse

```r
library(tidyverse)
library(stringi)

n_patient = 2
n_samples = 3
n_readgroup = 4
n_mate = 2

df = data.frame(patient   = rep(rep(LETTERS[1:n_patient], n_samples),2),
                sample    = rep(rep(seq(1:n_samples), each = n_patient),2),
                readgroup = rep(stri_rand_strings(n_patient * n_samples * n_readgroup, 6, '[A-Z]'),2),
                mate      = rep(1:n_mate, each = n_patient * n_samples * n_readgroup)) %>%
  mutate(file = sprintf("%s.%s.%s_%s", patient, sample, readgroup, mate)) %>%
  arrange(file)

> head(df)
  patient sample readgroup mate         file
1       A      1    FCSDRJ    1 A.1.FCSDRJ_1
2       A      1    FCSDRJ    2 A.1.FCSDRJ_2
3       A      1    IAXDPR    1 A.1.IAXDPR_1
4       A      1    IAXDPR    2 A.1.IAXDPR_2
5       A      1    MLDBKZ    1 A.1.MLDBKZ_1
6       A      1    MLDBKZ    2 A.1.MLDBKZ_2


json2 <- df %>% nest(-(1:2),.key=readgroups) %>% nest(-1,.key=samples)
json3 <- df %>% nest(-(1:3),.key=mate) %>% nest(-(1:2),.key=readgroups) %>% nest(-1,.key=samples)

jsonlite::toJSON(json3,pretty=T)

# output
[
  {
    "patient": "A",
    "samples": [
      {
        "sample": 1,
        "readgroups": [
          {
            "readgroup": "FUPEYR",
            "mate": [
              {
                "mate": 1,
                "file": "A.1.FUPEYR_1"
              },
              {
                "mate": 2,
                "file": "A.1.FUPEYR_2"
              }
...
```
And if necessary, generalize it:

```r
vars <- names(df)[-1] # or whatever variables you want to nest, order matters!
var_pairs <- map((length(vars)-1):1,~vars[.x:(.x+1)])
json4 <- reduce(var_pairs,~{nm<-.y[1];nest(.x,.y,.key=!!enquo(nm))},.init=df)

jsonlite::toJSON(json4,pretty=T)

[
  {
    "patient": "A",
    "sample": [
      {
        "sample": 1,
        "readgroup": [
          {
            "readgroup": "FUPEYR",
            "mate": [
              {
                "mate": 1,
                "file": "A.1.FUPEYR_1"
              },
              {
                "mate": 2,
                "file": "A.1.FUPEYR_2"
              }
...
```
### reorder within facet ggplot2

https://github.com/dgrtwo/drlib/blob/master/R/reorder_within.R

```r
#' Reorder an x or y axis within facets
#'
#' Reorder a column before plotting with faceting, such that the values are ordered
#' within each facet. This requires two functions: \code{reorder_within} applied to
#' the column, then either \code{scale_x_reordered} or \code{scale_y_reordered} added
#' to the plot.
#' This is implemented as a bit of a hack: it appends ___ and then the facet
#' at the end of each string.
#'
#' @param x Vector to reorder.
#' @param by Vector of the same length, to use for reordering.
#' @param within Vector of the same length that will later be used for faceting
#' @param fun Function to perform within each subset to determine the resulting
#' ordering. By default, mean.
#' @param sep Separator to distinguish the two. You may want to set this manually
#' if ___ can exist within one of your labels.
#' @param ... In \code{reorder_within} arguments passed on to \code{\link{reorder}}.
#' In the scale functions, extra arguments passed on to
#' \code{\link[ggplot2]{scale_x_discrete}} or \code{\link[ggplot2]{scale_y_discrete}}.
#'
#' @source "Ordering categories within ggplot2 Facets" by Tyler Rinker:
#' \url{https://trinkerrstuff.wordpress.com/2016/12/23/ordering-categories-within-ggplot2-facets/}
#'
#' @examples
#'
#' library(tidyr)
#' library(ggplot2)
#'
#' iris_gathered <- gather(iris, metric, value, -Species)
#'
#' # reordering doesn't work within each facet (see Sepal.Width):
#' ggplot(iris_gathered, aes(reorder(Species, value), value)) +
#'   geom_boxplot() +
#'   facet_wrap(~ metric)
#'
#' # reorder_within and scale_x_reordered work.
#' # (Note that you need to set scales = "free_x" in the facet)
#' ggplot(iris_gathered, aes(reorder_within(Species, value, metric), value)) +
#'   geom_boxplot() +
#'   scale_x_reordered() +
#'   facet_wrap(~ metric, scales = "free_x")
#'
#' @export
reorder_within <- function(x, by, within, fun = mean, sep = "___", ...) {
  new_x <- paste(x, within, sep = sep)
  stats::reorder(new_x, by, FUN = fun)
}


#' @rdname reorder_within
#' @export
scale_x_reordered <- function(..., sep = "___") {
  reg <- paste0(sep, ".+$")
  ggplot2::scale_x_discrete(labels = function(x) gsub(reg, "", x), ...)
}


#' @rdname reorder_within
#' @export
scale_y_reordered <- function(..., sep = "___") {
  reg <- paste0(sep, ".+$")
  ggplot2::scale_y_discrete(labels = function(x) gsub(reg, "", x), ...)
}
```

### separate multiple values in a field

```r
library(tidyverse)
> test_scores<- data_frame(student = c("Amy", "Belle", "Candice"), 
+                          score= c("75-81-86","87-89-90","92-93-99"))
> test_scores
# A tibble: 3 x 2
  student score   
  <chr>   <chr>   
1 Amy     75-81-86
2 Belle   87-89-90
3 Candice 92-93-99
> test_scores %>% separate(score, c("s1", "s2", "s3")) %>%
+         gather(key, score, -student) %>% select(-key)
# A tibble: 9 x 2
  student score
  <chr>   <chr>
1 Amy     75   
2 Belle   87   
3 Candice 92   
4 Amy     81   
5 Belle   89   
6 Candice 93   
7 Amy     86   
8 Belle   90   
9 Candice 99   
> 
> separate_rows(test_scores, score)
# A tibble: 9 x 2
  student score
  <chr>   <chr>
1 Amy     75   
2 Amy     81   
3 Amy     86   
4 Belle   87   
5 Belle   89   
6 Belle   90   
7 Candice 92   
8 Candice 93   
9 Candice 99 
```

### preview ggplot2 without saving to a file

from https://twitter.com/tjmahr/status/1083094031826124800?s=12

```r
library(ggplot2)
ggpreview <- function (..., device = "png") {
    fname <- tempfile(fileext = paste0(".", device))
    ggplot2::ggsave(filename = fname, device = device, ...)
    system2("open", fname)
    invisible(NULL)
}

g<- ggplot(mtcars, aes(x = hp, y = mpg)) + geom_point()

ggpreview(g, width = 5, height = 6, device = "pdf")

```

### group_split() and group_map(), group_walk()

dplyr >= 0.8.0 see this post https://www.johnmackintosh.com/2019-02-28-first-look-at-mapping-and-splitting-in-dplyr/
and this tweethttps://twitter.com/coolbutuseless/status/1101447111978205184?s=12

(a) group_split() + walk()
(b) group_by() + group_walk()

```r
library(tidyverse)
> mtcars %>% group_split(cyl) %>% walk(~print(head(.x,2)))
# A tibble: 2 x 11
    mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
1  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
2  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
# A tibble: 2 x 11
    mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
1    21     6   160   110   3.9  2.62  16.5     0     1     4     4
2    21     6   160   110   3.9  2.88  17.0     0     1     4     4
# A tibble: 2 x 11
    mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
1  18.7     8   360   175  3.15  3.44  17.0     0     0     3     2
2  14.3     8   360   245  3.21  3.57  15.8     0     0     3     4

## the cyl variable is not in the dataframe

> mtcars %>% group_by(cyl) %>% group_walk(~print(head(.x,2)))
# A tibble: 2 x 10
    mpg  disp    hp  drat    wt  qsec    vs    am  gear  carb
  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
1  22.8  108     93  3.85  2.32  18.6     1     1     4     1
2  24.4  147.    62  3.69  3.19  20       1     0     4     2
# A tibble: 2 x 10
    mpg  disp    hp  drat    wt  qsec    vs    am  gear  carb
  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
1    21   160   110   3.9  2.62  16.5     0     1     4     4
2    21   160   110   3.9  2.88  17.0     0     1     4     4
# A tibble: 2 x 10
    mpg  disp    hp  drat    wt  qsec    vs    am  gear  carb
  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
1  18.7   360   175  3.15  3.44  17.0     0     0     3     2
2  14.3   360   245  3.21  3.57  15.8     0     0     3     4
```

### hacking R lib path

https://milesmcbain.xyz/hacking-r-library-paths/

```r
set_lib_paths <- function(lib_vec) {

  lib_vec <- normalizePath(lib_vec, mustWork = TRUE)

  shim_fun <- .libPaths
  shim_env <- new.env(parent = environment(shim_fun))
  shim_env$.Library <- character()
  shim_env$.Library.site <- character()

  environment(shim_fun) <- shim_env
  shim_fun(lib_vec)

}

> .libPaths()
[1] "/home/miles/R/x86_64-pc-linux-gnu-library/3.6"
[2] "/usr/local/lib/R/site-library"                
[3] "/usr/lib/R/site-library"                      
[4] "/usr/lib/R/library"    

> set_lib_paths("~/code/library")
> .libPaths()
[1] "/home/miles/code/library"
```
### Sample from groups, n varies by group

https://jennybc.github.io/purrr-tutorial/ls12_different-sized-samples.html

```r
iris %>%
  group_by(Species) %>% 
  nest() %>%            
  mutate(n = c(2, 5, 3)) %>% 
  mutate(samp = map2(data, n, sample_n)) %>% 
  select(Species, samp) %>%
  unnest()
#> # A tibble: 10 x 5
#>    Species    Sepal.Length Sepal.Width Petal.Length Petal.Width
#>    <fct>             <dbl>       <dbl>        <dbl>       <dbl>
#>  1 setosa              5.4         3.4          1.7         0.2
#>  2 setosa              5.5         3.5          1.3         0.2
#>  3 versicolor          6.6         2.9          4.6         1.3
#>  4 versicolor          6.9         3.1          4.9         1.5
#>  5 versicolor          5.8         2.7          3.9         1.2
#>  6 versicolor          6           2.7          5.1         1.6
#>  7 versicolor          6.2         2.9          4.3         1.3
#>  8 virginica           6.4         3.2          5.3         2.3
#>  9 virginica           6.5         3            5.5         1.8
#> 10 virginica           6.1         3            4.9         1.8
```

also check `dplyr::sample_n()` and `dplyr::sample_frac()`

### ggplot2 reorder factor within facet

https://juliasilge.com/blog/reorder-within/

```r
library(tidyverse)
library(babynames)

top_names <- babynames %>%
    filter(year >= 1950,
           year < 1990) %>%
    mutate(decade = (year %/% 10) * 10) %>%
    group_by(decade) %>%
    count(name, wt = n, sort = TRUE) %>%
    ungroup

top_names

top_names %>%
    group_by(decade) %>%
    top_n(15) %>%
    ungroup %>%
    mutate(decade = as.factor(decade),
           name = reorder_within(name, n, decade)) %>%
    ggplot(aes(name, n, fill = decade)) +
    geom_col(show.legend = FALSE) +
    facet_wrap(~decade, scales = "free_y") +
    coord_flip() +
    scale_x_reordered() +
    scale_y_continuous(expand = c(0,0)) +
    labs(y = "Number of babies per decade",
         x = NULL,
         title = "What were the most common baby names in each decade?",
         subtitle = "Via US Social Security Administration")
```
