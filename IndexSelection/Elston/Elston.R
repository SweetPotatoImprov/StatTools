###############################################################################
# Elston Index
# Raul H. Eyzaguirre P.
###############################################################################

Elston <- function(traits, geno, data, lb=1) {
  
  geno <- as.character(substitute(geno))
  
  # inits
  
  nt <- length(traits) # number of traits
  k <- NULL
  ng <- nlevels(factor(data[,geno])) # number of genotypes
  
  # compute standardized means

  df <- data.frame(tapply(data[,traits[1]], data[,geno], mean, na.rm=T))
  if (nt > 1){
    for (i in 2:nt)
      df <- cbind(df, tapply(data[,traits[i]], data[,geno], mean, na.rm=T))
    for (i in 1:nt)
      df[,i+nt] <- (df[,i] - mean(df[,i]))/sd(df[,i])    
  }
  
  # compute lower bounds
  
  if (lb==1)
    for (i in 1:nt)
      k[i] <- min(df[,nt+i])
  
  if (lb==2)
    for (i in 1:nt)
      k[i] <- (ng * min(df[,nt+i]) - max(df[,nt+i]))/(ng-1)
  
  # Elston index
  
  df$EI <- df[,nt+1] - k[1]
  if (nt > 1)
    for (i in 2:nt)
      df$EI <- df$EI * (df[,nt+i] - k[i])

  orden <- order(df$EI, decreasing = T)
    
  # results
  
  list(Elston.Index=df$EI, Sorted.Elston.Index=df$EI[orden])
}
