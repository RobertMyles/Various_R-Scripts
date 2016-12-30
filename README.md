# various

In this repo are some R scripts and datasets that may be helpful. To run the scripts in R, you will need to set your working directory accordingly (to a downloaded version of this repo if you do that) or put the data somewhere you can find it easily.  

## List of scripts:  

1. - `color_table_tidyverse.R`. This is a tidyverse version of the handy color table (from [this R script](https://github.com/hdugan/rColorTable/blob/master/rColorTable.R)). I thought this was a useful little script, and a cool way to show what you can do in R, so I made a tidyverse version. The colors that have changing levels of hue go from left to right in terms of darkness (the base colour, and then versions 1 to 4, with 4 being the darkest). A pdf is created from the script, you can see it in the data folder.  

2. - `faster_for_loops.R`. People complain that for loops are slow in R. Firstly, R has many vectorized functions that do what you're probably trying to do much faster than you think, use those. If you need a for loop, and you know already the size of the desired resulting object, you can make the process faster by pre-allocating memory size (not a new trick, many have noted this before.)

3. - `Import&Bind_Multiple_DF.R`. This function reads the files of a certain file type (in the example .csv), imports them into R and binds them together. I saw a slightly different version of this a few years ago, but I can't remember where, otherwise I'd cite the author.  

4. - `538_baltimore_plot.R`. This script replicates the figure from the fivethirtyeight article on black men in Baltimore, Maryland (available [here](http://fivethirtyeight.com/datalab/how-baltimores-young-black-men-are-boxed-in/)). It is not the same because the data used are different, I was unable to find the exact data from the source fivethirtyeight cited.  
