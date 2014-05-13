###############################################################################
# Estimation of missing values for a RCBD and a MET in a RCBD
# Raul H. Eyzaguirre P.
###############################################################################

###############################################################################
# Function 1: Estimation of missing values in a RCBD
###############################################################################

mve.rcbd <- function(trait, geno=geno, rep=rep, data, maxp=0.05, tol=1e-06){
  
  # Everything as factor
  
  data[,"geno"] <- as.factor(data[,"geno"])
  data[,"rep"] <- as.factor(data[,"rep"])
  
  # Check frequencies by geno
  
  nmis <- sum(is.na(data[,trait]))
  subdata <- subset(data, is.na(data[,trait]) == 0)
  tfreq <- table(subdata[,"geno"])
  
  # Controls
  
  c1 <- 1 # Check for zeros. Initial state no zeros which is good
  c2 <- 0 # Check for replicates. Initial state only one replicate which is bad
  c3 <- 1 # Check for balance. Initial state balanced which is good
  
  for (i in 1:dim(tfreq)){
    if (tfreq[i] == 0) c1 <- 0 # State 0: there are zeros
    if (tfreq[i] > 1) c2 <- 1 # State 1: more than one replicate
    if (tfreq[i] != tfreq[1]) c3 <- 0 # State 0: unbalanced
  }
    
  # Error messages
  
  if (c1==0)
    stop("Error: Some genotypes have zero frequency.
         Remove genotypes to proceed.")
  
  if (c1==1 & c2==0)
    stop("Error: There is only one replication.
         Inference is not possible with one replication.")
      
  est.p <- mean(is.na(data[,trait]))
  if (est.p > maxp)
    stop(paste("Error: Too many missing values (", format(est.p*100,digits=3), "%).", sep=""))
  
  # Estimation
  
  G <- nlevels(data[,"geno"])
  trait.est <- paste(trait, ".est", sep="")
  R <- max(tfreq)
  data[,trait.est] <- data[,trait]
  data[,"ytemp"] <- data[,trait]
  mG <- tapply(data[,trait], data[,"geno"], mean, na.rm=T)
  for (i in 1:length(data[,trait]))
    if (is.na(data[i,trait]) == 1) data[i,"ytemp"] <- mG[data[i,"geno"]]
  lc1 <- array(0, nmis)
  lc2 <- array(0, nmis)
  cc <- max(data[,trait], na.rm=T)
  cont <- 0
  while (cc > max(data[,trait], na.rm=T)*tol & cont<100){
    cont <- cont+1
    for (i in 1:length(data[,trait]))
      if (is.na(data[i,trait]) == 1){
        data[i,"ytemp"] <- data[i,trait]
        sum1 <- tapply(data[,"ytemp"], data[,"geno"], sum, na.rm=T)
        sum2 <- tapply(data[,"ytemp"], data[,"rep"], sum, na.rm=T)
        sum3 <- sum(data[,"ytemp"], na.rm=T)
        data[i,trait.est] <- (G*sum1[data[i,"geno"]] + R*sum2[data[i,"rep"]] - sum3)/
                             (G*R - G - R + 1)
        data[i,"ytemp"] <- data[i,trait.est]
      }
    lc1 <- lc2
    lc2 <- subset(data, is.na(data[,trait])==1)[,trait.est]
    cc <- max(abs(lc1 - lc2))
  }
  
  list(new.data = data[,c("geno","rep",trait,trait.est)],
       est.num = nmis, est.prop = est.p)
}

###############################################################################
# Estimation of missing values for a MET with a RCBD
###############################################################################

mve.rcbd.met <- function(trait, geno=geno, env=env, rep=rep, data, maxp=0.05, tol=1e-06){
    
  # Everything as factor
  
  data[,"geno"] <- as.factor(data[,"geno"])
  data[,"env"] <- as.factor(data[,"env"])
  data[,"rep"] <- as.factor(data[,"rep"])
  
  # Check frequencies by geno and env
  
  nmis <- sum(is.na(data[,trait]))
  subdata <- subset(data, is.na(data[,trait]) == 0)
  tfreq <- table(subdata[,"geno"], subdata[,"env"])
  
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
  
  # Error messages
  
  if (c1==0)
    stop("Error: Some GxE cells have zero frequency.
         Remove genotypes or environments to proceed.")
  
  if (c1==1 & c2==0)
    stop("Error: There is only one replication.
         Inference is not possible with one replication.")
      
  est.p <- mean(is.na(data[,trait]))
  if (est.p > maxp)
    stop(paste("Error: Too many missing values (", format(est.p*100,digits=3), "%).", sep=""))
  
  G <- nlevels(data[,"geno"])
  E <- nlevels(data[,"env"])
  if (G < 2 | E < 2)
    stop(paste("Error: This is not a MET experiment."))
  
  # Estimation
  
  trait.est <- paste(trait, ".est", sep="")
  R <- max(tfreq)
  data[,trait.est] <- data[,trait]
  data[,"ytemp"] <- data[,trait]
  mGE <- tapply(data[,trait], list(data[,"geno"], data[,"env"]), mean, na.rm=T)
  for (i in 1:length(data[,trait]))
    if (is.na(data[i,trait]) == 1) data[i,"ytemp"] <- mGE[data[i,"geno"], data[i,"env"]]
  lc1 <- array(0, nmis)
  lc2 <- array(0, nmis)
  cc <- max(data[,trait], na.rm=T)
  cont <- 0
  while (cc > max(data[,trait], na.rm=T)*tol & cont<100){
    cont <- cont+1
    for (i in 1:length(data[,trait]))
      if (is.na(data[i,trait]) == 1){
        data[i,"ytemp"] <- data[i,trait]
        sum1 <- tapply(data[,"ytemp"], list(data[,"geno"], data[,"env"]), sum, na.rm=T)
        sum2 <- tapply(data[,"ytemp"], list(data[,"env"], data[,"rep"]), sum, na.rm=T)
        sum3 <- tapply(data[,"ytemp"], data[,"env"], sum, na.rm=T)
        data[i,trait.est] <- (G*sum1[data[i,"geno"], data[i,"env"]] +
                                R*sum2[data[i,"env"], data[i,"rep"]] -
                                sum3[data[i,"env"]]) / (G*R - G - R + 1)
        data[i,"ytemp"] <- data[i,trait.est]
      }
    lc1 <- lc2
    lc2 <- subset(data, is.na(data[,trait])==1)[,trait.est]
    cc <- max(abs(lc1 - lc2))
  }
  
  list(new.data = data[,c("geno","env","rep",trait,trait.est)],
       est.num = nmis, est.prop = est.p)
}
