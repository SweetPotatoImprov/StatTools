###############################################################################
# Function for Regression Stability Analysis
# Raul H. Eyzaguirre P.
###############################################################################

## Required functions

if ('mve.rcbd.met' %in% lsf.str() == F)
  if ('MissValEst.R' %in% list.files() == T) source("MissValEst.R") else {
    urlfile <- 'https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/MissValEst/MissValEst.R'
    source(urlfile)
  }
    
## Function RegStab

RegStab <- function(trait, geno, env, rep, data, maxp = 0.05){
  
  # Everything as factor
  
  data[,geno] <- factor(data[,geno])
  data[,env] <- factor(data[,env])
  data[,rep] <- factor(data[,rep])

  # Check data and estimate missing values
  
  lc <- CheckData02(trait, geno, env, rep, data)
  
  if (lc$c1 == 0 | lc$c2 == 0 | lc$c3 == 0){
    est.data <- mve.rcbd.met(trait, geno, env, rep, data, maxp, tol = 1e-06)
    data[,trait] <- est.data$new.data[,5]
    nmis <- est.data$est.num
    warning(paste("Warning: The data set is unbalanced, ",
                  format(est.data$est.prop*100, digits = 3),
                  "% missing values estimated.", sep = "")) 
  }
  
  # Error messages
  
  geno.num <- nlevels(data[,geno])
  env.num <- nlevels(data[,env])
  rep.num <- nlevels(data[,rep])
  
  if (geno.num < 2 | env.num < 2)
    stop(paste("Error: This is not a MET experiment."))
  
  if (geno.num == 2 & env.num == 2)
    stop(paste("Error: You need at least 3 genotypes or 3 environments for regression stability analysis."))
  
  # Some statistics
  
   int.mean <- tapply(data[,trait], list(data[,geno], data[,env]), mean, na.rm=T)
   overall.mean <- mean(int.mean, na.rm=T)
   env.mean <- apply(int.mean, 2, mean, na.rm=T)
   geno.mean <- apply(int.mean, 1, mean, na.rm=T)
  
  # Regression-stability for genotypes
  
  a <- NULL
  b <- NULL
  se <- NULL
  ms_dev <- NULL
  ms_gxe <- NULL
  ms_entry <- NULL
  ms_reg <- NULL
  
  for (i in 1:geno.num){
    modelo <- lm(int.mean[i,] ~ env.mean)
    a[i] <- coef(modelo)[1]
    b[i] <- coef(modelo)[2]
    se[i] <- summary.lm(modelo)$coefficients[2,2]
    ms_dev[i] <- anova(modelo)[2,3] 
    ms_gxe[i] <- sum((int.mean[i,] - geno.mean[i] - env.mean + overall.mean)^2)/(env.num - 1)
    ms_entry[i] <- sum((int.mean[i,] - geno.mean[i])^2)/(env.num - 1)
  }
  stability_geno <- cbind(b, se, ms_dev, ms_entry, ms_gxe)
  row.names(stability_geno) <- levels(data[,geno])
  names(a) <- levels(data[,geno])
  names(b) <- levels(data[,geno])
  if (env.num > 2){
    x <- NULL
    ypred <- NULL
    ymean <- NULL
    for (i in 1:length(data[,trait])){
      x[i] <- env.mean[names(env.mean)==data[i,env]]
      ypred[i] <- a[names(a)==data[i,geno]] + b[names(b)==data[i,geno]]*x[i]
      ymean[i] <- int.mean[row.names(int.mean)==data[i,geno], colnames(int.mean)==data[i,env]]
    }
    drg_sc <- sum((ypred - ymean)^2)
    hrg_gl <- geno.num - 1
    drg_gl <- (geno.num - 1)*(env.num - 1) - hrg_gl
    drg_cm <- drg_sc/drg_gl	
  } else {
    drg_sc <- NA
    hrg_gl <- NA
    drg_gl <- NA
    drg_cm <- NA
  }
  
  # Regression-stability for environments
  
  a <- NULL
  b <- NULL
  se <- NULL
  ms_dev <- NULL
  ms_gxe <- NULL
  ms_entry <- NULL
  ms_reg <- NULL
  
  for (i in 1:env.num){
    modelo <- lm(int.mean[,i] ~ geno.mean)
    a[i] <- coef(modelo)[1]
    b[i] <- coef(modelo)[2]
    se[i] <- summary.lm(modelo)$coefficients[2,2]
    ms_dev[i] <- anova(modelo)[2,3]
    ms_gxe[i] <- sum((int.mean[,i] - env.mean[i] - geno.mean + overall.mean)^2)/(geno.num - 1)
    ms_entry[i] <- sum((int.mean[,i] - env.mean[i])^2)/(geno.num - 1)
  }
  stability_env <- cbind(b, se, ms_dev, ms_entry, ms_gxe)
  row.names(stability_env) <- levels(data[,env])
  names(a) <- levels(data[,env])
  names(b) <- levels(data[,env])
  if (geno.num > 2){
    x <- NULL
    ypred <- NULL
    ymean <- NULL
    for (i in 1:length(data[,trait])){
      x[i] <- geno.mean[names(geno.mean)==data[i,geno]]
      ypred[i] <- a[names(a)==data[i,env]] + b[names(b)==data[i,env]]*x[i]
      ymean[i] <- int.mean[row.names(int.mean)==data[i,geno], colnames(int.mean)==data[i,env]]
    }
    dre_sc <- sum((ypred-ymean)^2)
    hre_gl <- env.num - 1
    dre_gl <- (geno.num - 1)*(env.num - 1) - hre_gl
    dre_cm <- dre_sc/dre_gl
  } else {
    dre_sc <- NA
    hre_gl <- NA
    dre_gl <- NA
    dre_cm <- NA
  }
  
  # ANOVA

  add.anova <- aov(data[,trait] ~ data[,geno] + data[,env] + data[,rep] %in% data[,env] + data[,geno]:data[,env])
  at <- summary(add.anova)
  at <- cbind(at[[1]][,1:4], at[[1]][,5])
  at[5,1] <- at[5,1] - nmis
  at[5,3] <- at[5,2]/at[5,1]
  at[1:4,4] <- at[1:4,3]/at[5,3]
  at[1:4,5] <- pf(at[1:4,4], at[1:4,1], at[5,1], lower.tail=F)
  
  # ANOVA plus regression stability
    
  if (env.num > 2){
    hrg_sc <- at[4,2] - drg_sc
    hrg_cm <- hrg_sc/hrg_gl
    hrg_f <- hrg_cm/drg_cm
    hrg_p <- pf(hrg_f, hrg_gl, drg_gl, lower.tail=F)
    drg_f <- drg_cm/at[5,3]
    drg_p <- pf(drg_f, drg_gl, at[5,1], lower.tail=F)
  } else {
    hrg_sc <- NA
    hrg_cm <- NA
    hrg_f <- NA
    hrg_p <- NA
    drg_f <- NA
    drg_p <- NA
  }
  if (geno.num > 2){
    hre_sc <- at[4,2] - dre_sc
    hre_cm <- hre_sc/hre_gl	
    hre_f <- hre_cm/dre_cm
    hre_p <- pf(hre_f, hre_gl, dre_gl, lower.tail=F)
    dre_f <- dre_cm/at[5,3]
    dre_p <- pf(dre_f, dre_gl, at[5,1], lower.tail=F)
  } else {
    hre_sc <- NA
    hre_cm <- NA
    hre_f <- NA
    hre_p <- NA
    dre_f <- NA
    dre_p <- NA
  }
  at[2,4] <- at[2,3]/at[3,3]
  at[2,5] <- pf(at[2,4], at[2,1], at[3,1], lower.tail=F)
  filaux <- at[5,]
  at[5,] <- c(hrg_gl, hrg_sc, hrg_cm, hrg_f, hrg_p)
  at <- rbind(at, c(drg_gl, drg_sc, drg_cm, drg_f, drg_p))
  at <- rbind(at, c(hre_gl, hre_sc, hre_cm, hre_f, hre_p))
  at <- rbind(at, c(dre_gl, dre_sc, dre_cm, dre_f, dre_p))
  at[9,] <- filaux
  at[1,6] <- qt(.975, at[9,1])*sqrt(at[9,3]*2/rep.num/env.num)
  at[2,6] <- qt(.975, at[3,1])*sqrt(at[3,3]*2/rep.num/geno.num)
  at[4,6] <- qt(.975, at[9,1])*sqrt(at[9,3]*2/rep.num)
  row.names(at) <- c("G", "E", "R:E", "GxE", "- Het.Regr.G", "- Dev.Regr.G",
                     "- Het.Regr.E", "- Dev.Regr.E", "Residuals")
  colnames(at)[5:6] <- c("Pr(>F)", "LSD5")
  cv <- sqrt(at[5,3])/abs(overall.mean)*100 
  
  # Return
  
  list(anova.table = at, cv = cv)
}

