#!/usr/bin/env Rscript

suppressMessages(library(optparse))
suppressMessages(library(plyr))

option_list <- list(
  make_option(c('--columns', '-c'), help='cut columns'),
  make_option(c('--count', '-z'), help='add counts column', default=F, action='store_true'),
  make_option(c('--no-header'), help='This file does not have a header', default=F, action='store_true')
  )
#option_list <- list()
opts <- parse_args(OptionParser(
      option_list=option_list,
      usage=paste("%prog [options] input output\n",
                  "    (input and output default to stdin and stdout respectively.)\n")),
    positional_arguments=T)



# first is input file, second is output - default to sdtin and sdtout resp
args <- opts$args
opts <- opts$options

input.f <- args[1]
output.f <- args[2]

input.f <- if (!is.na(input.f) && !is.null(input.f)) args[1] else 'stdin'
output.f <- if (!is.na(output.f) && !is.null(output.f)) args[1] else 'stdout'

data <- read.csv(input.f, header=!opts$`no-header`)

if (!is.null(opts$columns)) {
  cols <- strsplit(opts$columns, ',')[[1]]
  data <- data[cols]
} else {
  cols <- names(data)
}

if (opts$count) {
  data <- ddply(data, .variables=cols, function(df) c(count=dim(df)[1]))
} else {
  data <- unique(data)
}

write.csv(data, stdout(), row.names=F, quote=F)

