
http://stackoverflow.com/questions/41231209/r-define-distinct-pattern-from-values-of-multiple-variables

add a unique id for rows with the same values on columns 
```r
dplyr::group_indices()

data.frame(x=c(0,0,0,1,1,1), y=c(0,0,1,0,1,1))

group_indices(df, x, y)

df %>% mutate(pattern = group_indices_(df, .dots = c('x', 'y')))

```
