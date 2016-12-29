# To get faster for loops in R, we need to 
# pre-allocate the memory, using length():

outcome_object <- c(NA)
length(outcome_object ) <- 100000

for(i in 1:100000) {
  outcome_object[i] <- i
  }
