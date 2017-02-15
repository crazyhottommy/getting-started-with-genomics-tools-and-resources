
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
