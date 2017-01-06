
http://stackoverflow.com/questions/41231209/r-define-distinct-pattern-from-values-of-multiple-variables

add a unique id for rows with the same values on columns 
```r
dplyr::group_indices()

data.frame(x=c(0,0,0,1,1,1), y=c(0,0,1,0,1,1))

group_indices(df, x, y)

df %>% mutate(pattern = group_indices_(df, .dots = c('x', 'y')))

```

alternative to nested `ifelse`:
```r
library(dplyr)
case_when

cars %>% as_tibble %>% mutate(case_code = case_when(
                              speed == 4 & dist == 2 ~ "this",
                              dist > 6 & dist == 10 ~ "is",
                              speed >=10 & dist >= 18 ~ "awesome"))
                   

```

choose the max value of a group

```r
df %>% group_by(A, B) %>% top_n(n=1, wt= C)
df %>% group_by(A,B) %>% slice(which.max(C))
df %>% group_by(A, B) %>% filter(value == max(C)) 
```
