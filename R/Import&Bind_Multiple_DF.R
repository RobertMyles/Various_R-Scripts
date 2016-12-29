# this function imports lots of files from a single source (a folder)
# and binds them in a dataframe. 
rm(list=ls())
library(data.table)

# you need to set your working directory to the folder in question
# for this to work.uses getwd(), so might need to set it first:

# setwd("")

# in this example, I'll use .csv files, but if you have other types, just use the 
# appropriate function and suffix. I'm also using lapply() to avoid loading 
# packages, but you can use purrr::map() to the same end.

# Depending on the files themselves, you may of course need to 
# set other options here, such as the fill = TRUE below.

files <- dir(path = getwd(), pattern = "*.csv")

all_files <- rbindlist(lapply(files, fread, header = TRUE, 
                              sep=",", na.strings=c("NA", '')),
                       fill = TRUE)

