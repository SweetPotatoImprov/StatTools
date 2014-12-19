###############################################################################
# Functions to check data characteristics.
# Raul H. Eyzaguirre P.
###############################################################################

###############################################################################
# Function 1: Check data for a RCBD
###############################################################################

CheckData01 <- function(trait, geno, data){
  
  # Check frequencies by geno
  
  nmis <- sum(is.na(data[,trait]))
  subdata <- subset(data, is.na(data[,trait]) == 0)
  tfreq <- table(subdata[,geno])
  
  # Controls
  
  c1 <- 1 # Check for zeros. Initial state no zeros which is good
  c2 <- 0 # Check for replicates. Initial state only one replicate which is bad
  c3 <- 1 # Check for balance. Initial state balanced which is good
  
  for (i in 1:dim(tfreq)){
    if (tfreq[i] == 0) c1 <- 0 # State 0: there are zeros
    if (tfreq[i] > 1) c2 <- 1 # State 1: more than one replicate
    if (tfreq[i] != tfreq[1]) c3 <- 0 # State 0: unbalanced
  }
  
  # Return
  
  list(c1 = c1, c2 = c2, c3 = c3, nmis = nmis)
}

###############################################################################
# Function 2: Check data for a MET in a RCBD
###############################################################################

CheckData02 <- function(trait, geno, env, data){
  
  # Check frequencies by geno and env
  nmis <- sum(is.na(data[,trait]))
  subdata <- subset(data, is.na(data[,trait]) == 0)
  tfreq <- table(subdata[,geno], subdata[,env])
  
  # Controls
  
  c1 <- 1 # Check for zeros. Initial state no zeros which is good
  c2 <- 0 # Check for replicates. Initial state only one replicate which is bad
  c3 <- 1 # Check for balance. Initial state balanced which is good
  
  for (i in 1:dim(tfreq)[1])
    for (j in 1:dim(tfreq)[2]){
      if (tfreq[i,j] == 0) c1 <- 0 # State 0: there are zeros
      if (tfreq[i,j] > 1) c2 <- 1 # State 1: more than one replicate
      if (tfreq[i,j] != tfreq[1,1]) c3 <- 0 # State 0: unbalanced
    }
  
  # Return
  
  list(c1 = c1, c2 = c2, c3 = c3, nmis = nmis)
}
