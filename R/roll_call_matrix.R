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
# each vote. These must be named "Legis_ID", "Vote", and "Vote_ID" for this 
# function to work.
# The votes should also be numeric for any further analysis (e.g. Yes = 1, 
# No = 0), but this is not required for the function to work.

# The resulting matrix will have dimensions N x M, where N is the number of 
# legislators (as row names in the non-Stan version) and M the number of votes
# (likewise as column names for the non-Stan version).
# the pscl package will be installed if the pscl option is marked TRUE.

load("/Users/robert/Replication-files_Formal-Comparisons-of-Legislative-Institutions/data/votes.Rda")
votes <- votes %>% 
  rename(Legis_ID = ID, Vote = Voto, Vote_ID = PROJ.ANO) %>% 
  filter(date >= "1995-01-01", date <= "1999-01-01") %>% 
  select(Legis_ID, Vote, Vote_ID)
  

rollcallmatrix <- function(x, pscl = FALSE, Stan = FALSE){
  
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
  
  if(pscl == FALSE & Stan == FALSE){
    message("Returning matrix of votes and legislators\n")
    return(rollCallMatrix)
  } else if(pscl == TRUE & Stan == FALSE){
    message("Returning rollcall object\n")
    rollcallObj_1 <- rollcall(rollCallMatrix)
    return(rollcallObj_1)
  } else if(pscl == FALSE & Stan == TRUE){
    
    miss <- which(is.na(rollCallMatrix))
    StanObject <- rollCallMatrix[-miss]
    
    message("Returning rollcall object for Stan\n")
    return(StanObject)
  }
}
