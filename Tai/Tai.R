###############################################################################
# Function to compute the Tai's stability analysis.
# It assumes a RCBD with fixed effects for geno and random effects for env.
# Raul H. Eyzaguirre P.
###############################################################################

## Required functions

if ('CheckData02' %in% lsf.str() == F)
  if ('CheckData.R' %in% list.files() == T) source("CheckData.R") else {
    urlfile <- 'https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/CheckData/CheckData.R'
    source(urlfile)
  }

## Tai function

Tai <- function(trait, geno, env, rep, data, conf = 0.95, file.name = NULL,
                title = NULL, color = c("darkorange", "black", "gray"),
                Gsize = 600, ...){
  
  # Everything as factor
  
  data[,geno] <- factor(data[,geno])
  data[,env] <- factor(data[,env])
  data[,rep] <- factor(data[,rep])

  # Check data
  
  lc <- CheckData02(trait, geno, env, rep, data)
  
  # Error messages
  
  if (lc$c1 == 0)
    stop("Error: Some GxE cells have zero frequency. Remove genotypes or environments to proceed.")
  
  if (lc$c1 == 1 & lc$c2 == 0)
    warning("Warning: There is only one replication. Inference is not possible with one replication.")
  
  if (lc$c1 == 1 & lc$c2 == 1 & lc$c3 == 0)
    warning("Warning: The data set is unbalanced.")
  
  geno.num <- nlevels(data[,geno])
  env.num <- nlevels(data[,env])
  rep.num <- nlevels(data[,rep])
  
  if (geno.num < 2 | env.num < 2)
    stop(paste("Error: This is not a MET experiment."))
  
  if (geno.num < 3 | env.num < 3)
    stop(paste("Error: You need at least 3 genotypes and 3 environments to run Tai"))
  
  # Compute interaction effects matrix
    
  int.mean <- tapply(data[,trait], list(data[,geno], data[,env]), mean, na.rm = T)
  
  overall.mean <- mean(int.mean)
  env.mean <- apply(int.mean, 2, mean)
  geno.mean <- apply(int.mean, 1, mean)
  int.eff <- int.mean + overall.mean
  for (i in 1:env.num) int.eff[,i] <- int.eff[,i] - geno.mean
  for (i in 1:geno.num) int.eff[i,] <- int.eff[i,] - env.mean

  # ANOVA
  
  model <- aov(data[,trait] ~ data[,geno] + data[,env] +
                 data[,rep] %in% data[,env] + data[,geno]:data[,env])  
  at <- summary(model)
  
  if (at[[1]][3,3] > at[[1]][2,3])
    stop(paste("Error: MS for blocks is greater than MS for environments"))

  # Compute Tai values alpha and lambda
  
  slgl <- int.eff
  for (i in 1:geno.num) slgl[i,] <- slgl[i,]*(env.mean - overall.mean)/(env.num-1)
  alpha <- apply(slgl, 1, sum)/(at[[1]][2,3]-at[[1]][3,3])*geno.num*rep.num
  
  s2gl <- int.eff
  for (i in 1:geno.num) s2gl[i,] <- s2gl[i,]^2/(env.num-1)
  lambda <- (apply(s2gl, 1, sum) - alpha*apply(slgl, 1, sum))/(geno.num-1)/
    at[[1]][5,3]*geno.num*rep.num
  
  # plot lambda limits
  
  lmax <- max(c(lambda, qf(1-(1-conf)/2, env.num-2, env.num*(geno.num-1)*(rep.num-1))))*1.1
  
  # Prediction interval for alpha
  
  lx <- seq(0,lmax,lmax/100)
  ta <- qt(1-(1-conf)/2, env.num-2)
  pi.alpha <- ta * ((lx * (geno.num-1) * at[[1]][5,3] * at[[1]][2,3]) /
                      (at[[1]][2,3] - at[[1]][3,3]) /
                      ((env.num-2) * at[[1]][2,3] - (ta^2 + env.num - 2)
                       * at[[1]][3,3]))^.5
  
  # plot alpha limits
  
  amax <- max(c(abs(alpha), pi.alpha))
  
  # Tai plot
  
  if (is.null(title) == 1)
    title = paste("Tai stability analysis for ", trait, sep = "")  
  
  if (is.null(file.name) == 1)
    file.name = paste("tai_", trait, ".png", sep = "") else
      file.name = paste(file.name, ".png", sep = "")

  png(filename = file.name, width = Gsize, height = Gsize)
  plot(1, type = "n", xlim = c(-0.05*lmax, lmax), ylim = c(-amax, amax),
       main = title, xlab = expression(lambda), ylab = expression(alpha), ...)
  points(lambda, alpha, col = color[1], lwd = 2, pch = 4, ...)
  text(lambda, alpha, labels = names(alpha), col = color[2], pos = 1, offset = .3)
  points(lx, pi.alpha, type = "l", lty = 3, col = color[3])
  points(lx, -pi.alpha, type = "l", lty = 3, col = color[3])
  abline(v = qf((1-conf)/2, env.num-2, env.num*(geno.num)*(rep.num-1)),
         lty = 3, col = color[3])
  abline(v = qf(1-(1-conf)/2, env.num-2, env.num*(geno.num)*(rep.num-1)),
         lty = 3, col = color[3])
  dev.off()
  
  # Output
  
  coords <- cbind(alpha, lambda)
  return(coords)
}