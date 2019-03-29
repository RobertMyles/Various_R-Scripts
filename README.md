# Various R Scripts

In this repo are some R scripts and datasets that may be helpful. To run the scripts in R, you will need to set your working directory accordingly (to a downloaded version of this repo if you do that) or put the data somewhere you can find it easily.  

## List of scripts:  

 - [`color_table_tidyverse.R`](https://github.com/RobertMyles/Various_R-Scripts/blob/master/R/color_table_tidyverse.R). This is a tidyverse version of a handy color table (from [this R script](https://github.com/hdugan/rColorTable/blob/master/rColorTable.R)). I thought this was a useful little script, and a cool way to show what you can do in R, so I made a tidyverse version. The colors that have changing levels of hue go from left to right in terms of darkness. First comes the base colour, and then versions 1 to 4, with 4 being the darkest (the base can often be darker than 1 and 2). So if you want to use the darkest level of 'wheat' in an R plot, use 'wheat4'. A pdf is created from the script, you can see it in the data folder. It looks like this:  

 <img src = 'http://i.imgur.com/JVXhXyj.png?1'>

 - [`roll_call_matrix.R`](https://github.com/RobertMyles/Various_R-Scripts/blob/master/R/roll_call_matrix.R). This function takes vote data (in a certain format) as input and returns a matrix which can be used with `MCMCpack`, `JAGS`, or `BUGS` for ideal-point analyses. The function can also return a rollcall object, for use with the `pscl` and `wnominate` packages, or a vector (where `NA` have been deleted) for use with Stan. It can be used with the data file `senate_example.csv` in the data folder.    

 - [`ideal_point_plots.R`](https://github.com/RobertMyles/Various_R-Scripts/blob/master/R/ideal_point_plots.R). This script contains a function that takes an MCMC summary object (from the coda package function `summary()`) and creates a ggplot ideal point graph from it, using either no colours, or colours determined by party or coalition membership. Since plots can be tricky things to get right to *your* exact taste, I recommend tweaking the function to get exactly what you want.  The default (using government coalition membership to colour) looks like this:

<img src = 'http://i.imgur.com/NZu0k9w.png'>

 - [`ideal_point_example.R`](https://github.com/RobertMyles/Various_R-Scripts/blob/master/R/ideal_point_example.R). This script shows a simple run-through of the functions above, using the senate_example data in the data folder.

 - [`faster_for_loops.R`](https://github.com/RobertMyles/Various_R-Scripts/blob/master/R/faster_for_loops.R). People complain that for loops are slow in R. Firstly, R has many vectorized functions that do what you're probably trying to do much faster than you think, use those. If you need a for loop, and you know already the size of the desired resulting object, you can make the process faster by pre-allocating memory size (not a new trick, many have noted this before.)

 - [`Import&Bind_Multiple_DF.R`](https://github.com/RobertMyles/Various_R-Scripts/blob/master/R/Import%26Bind_Multiple_DF.R). This function reads the files of a certain file type (in the example .csv), imports them into R and binds them together. I saw a slightly different version of this a few years ago, but I can't remember where, otherwise I'd cite the author.  

 - [`stacked_percentage_barchart.R`](https://github.com/RobertMyles/Various_R-Scripts/blob/master/R/stacked_percentage_barchart.R). Make a stacked bar chart showing percentages in different categories. Useful for showing how respondents vary over different categories. The percentages are shown inside the bars, with their position determined by the relative percentages in the category. It looks like this:
<img src = "http://i.imgur.com/T55W6vc.png">

 - [`538_baltimore_plot.R`](https://github.com/RobertMyles/Various_R-Scripts/blob/master/R/538_baltimore_plot.R). This script replicates the figure from the fivethirtyeight article on black men in Baltimore, Maryland (available [here](http://fivethirtyeight.com/datalab/how-baltimores-young-black-men-are-boxed-in/)). It is not the same because the data used are different, I was unable to find the exact data from the source fivethirtyeight cited. The general idea is to show how you can replicate high-quality publication-ready visualizations in R. For another example of doing this type of thing to replicate figures from The Economist, see my blog post [here](http://robertmylesmcdonnell.com/re-creating-plots-from-the-economist-in-r.html).


## Data:
- `senate_example.csv`: nominal voting example data.  
- `black_2015_income.csv`; `population.csv`; `white_2015_income.csv`: replication data for the fivethirtyeight plot.  
- `color_chart_dplyr.pdf`: colour table made from the script above.
