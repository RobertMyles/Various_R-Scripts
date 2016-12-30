# takes a dataset of roll call votes and transforms the relevant variables
# into a rollcall matrix, suitable for use with the pscl, wnominate and MCMCpack
# packages (nominate and pscl require a transformation into a rollcall object, 
# implemented as the pscl option equal to TRUE in the function). 
# This matrix can also be used with the sampling software programs 
# Stan, JAGS and BUGS. Stan will not accept NA, so if you wish to use 
# the function with Stan, use the argument Stan = TRUE.

# In order to use this function, you will need three columns in your votes 
# dataset (x): the IDs of the legislators (or names); 
# the votes that they cast; an ID for 
# each vote. These **must** be named "Legis_ID", "Vote", and "Vote_ID" for this 
# function to work.
# Vote must be numeric. The easiest format is 1 = "Yes", 0 = "No", NA for
# everything else.

# The resulting matrix will have dimensions N x M, where N is the number of 
# legislators (as row names in the non-Stan version) and M the number of votes
# (likewise as column names for the non-Stan version).
# the pscl package will be installed if the pscl option is marked TRUE.

# If you wish to include details on the legislators (party, state etc), use 
# Legis = TRUE. In order to use this function, you will need one or more of
# these variables, that **must** be named 'party', 'gov_coalition', and 
# 'state'.
# If Legis is TRUE, the object returned will be a list of two elements, 
# the rollcall matrix/object/vector, and a dataframe of legislator 
# characteristics. If you have a column of legislator names and wish to use 
#this instead of IDs (for plotting purposes etc), simply name this column 
# "Legis_ID". You will need the tidyverse package to run this.

library(tidyverse)

rollcallmatrix <- function(x, pscl = FALSE, Stan = FALSE, 
                           Legis = FALSE, names = FALSE){
  
  if(pscl == TRUE & Stan == TRUE){
    return(message("Error: arguments 'pscl' and 'Stan' cannot both be TRUE."))
  }
  
  if(!require("pacman")) install.packages("pacman")
  suppressMessages(library(pacman))
  pacman::p_load(char=c("pscl"), install=TRUE)
  
  legislatorId <- x$Legis_ID
  voteId <- x$Vote_ID
  vote <- x$Vote
  nameID <- unique(legislatorId)
  n <- length(unique(nameID))
  m <- length(unique(voteId))
  
  rollCallMatrix <- matrix(NA, n, m)
  name_row <- match(legislatorId, nameID)
  name_col <- unique(voteId)
  name_col <- match(voteId, name_col)
  
  for(k in 1:length(legislatorId)){
    rollCallMatrix[name_row[k], name_col[k]] <- vote[k]
  }
  
  rollCallMatrix <- matrix(as.numeric(unlist(rollCallMatrix)), 
                           nrow = nrow(rollCallMatrix))
  dimnames(rollCallMatrix) <- list(unique(nameID), unique(voteId))
  
  
  Leg <- data_frame(Legislator = unique(nameID),
                    Party = x$party[match(unique(nameID),
                                          x$Legis_ID)],
                    State = x$state[match(unique(nameID),
                                          x$Legis_ID)],
                    GovCoalition = x$gov_coalition[match(unique(nameID),
                                                         x$Legis_ID)])
  
  if(Legis == TRUE & pscl == FALSE & Stan == FALSE){
    
    Legis_data <- Leg
    message("Returning rollcall matrix and legislator characteristics")
    list_m <- list(rollCallMatrix = rollCallMatrix, 
                   Legis_data = Legis_data)
    return(list_m)
    
  } else if(Legis == TRUE & pscl == TRUE){
    
    rollcallObj_1 <- rollcall(rollCallMatrix)
    Legis_data <- Leg
    list_rc_pscl <- list(rollCallObject = rollcallObj_1, 
                         Legis_data = Legis_data)
    message("Returning list of rollcall object and legislator\ncharacteristics for pscl")
    return(list_rc_pscl)
  } else if(Legis == TRUE & Stan == TRUE){
    
    miss <- which(is.na(rollCallMatrix))
    StanObject <- rollCallMatrix[-miss]
    Legis_data <- Leg
    list_rc_stan <- list(StanObject = StanObject, 
                         Legis_data = Legis_data)
    message("Returning list of rollcall vector and legislator \ncharacteristics for Stan")
    return(list_rc_stan)
    
  } else if(pscl == FALSE & Stan == FALSE & Legis == FALSE){
    
    message("Returning rollcall matrix")
    return(rollCallMatrix = rollCallMatrix)
    
  } else if(pscl == TRUE & Stan == FALSE){
    
    message("Returning rollcall object")
    rollcallObj_1 <- rollcall(rollCallMatrix)
    return(rollcallObject = rollcallObj_1)
    
  } else if(pscl == FALSE & Stan == TRUE){
    
    miss <- which(is.na(rollCallMatrix))
    StanObject <- rollCallMatrix[-miss]
    message("Returning rollcall object for Stan")
    return(StanObject = StanObject)
    
  } 
}
