
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
### first and last row in a group
```r
df %>% arrange(stopSequence) %>% group_by(id) %>% slice(c(1,n()))
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
