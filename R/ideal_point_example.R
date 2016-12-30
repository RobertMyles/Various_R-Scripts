library(tidyverse)
library(MCMCpack)

sen <- read_csv("data/senate_example.csv")
source("R/roll_call_matrix.R")
source("R/ideal_point_plots.R")

# create rollcall matrix, run IRT model with MCMCpack, create summary:
y <- rollcallmatrix(sen, Legis = T)
yy <- MCMCirt1d(y$rollCallMatrix) # takes a minute or so
mcmc <- summary(yy)


# Plots: 
ideal_plot(mcmc = mcmc)
ideal_plot(mcmc, Legis = TRUE, rc = y)
ideal_plot(mcmc, Legis = TRUE, rc = y, Party = T)


