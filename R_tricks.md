
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
