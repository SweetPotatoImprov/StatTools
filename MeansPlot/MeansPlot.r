###############################################################################
# Function to plot means and confidence limits.
# Raul H. Eyzaguirre P.
###############################################################################

MeansPlot <- function(trait, groups, data, conf = 0.95, sort.means = "none",
                      main.title = "", x.title = "groups", y.title = "",
                      col = "black", bg = "darkorange", col.lines = "black") {
  
  # means and standard deviations
  
  means <- tapply(data[,trait], data[,groups], mean, na.rm=T)
  sdev <- tapply(data[,trait], data[,groups], sd, na.rm=T)
  
  resu <- data.frame(means, sdev)
  
  # compute confidence intervals
  
  resu$n <- tapply(is.na(data[, trait])==0, data[,groups], sum)
  resu$li <- resu$means - qt((1 + conf)/2, n) * resu$sdev/sqrt(resu$n)
  resu$ls <- resu$means + qt((1 + conf)/2, n) * resu$sdev/sqrt(resu$n)
  
  # sort
  
  if (sort.means == "increasing")
    resu <- resu[sort(resu$means, index.return=T)$ix,]
  if (sort.means == "decreasing")
    resu <- resu[sort(resu$means, decreasing=T, index.return=T)$ix,]
  if (sort.means %in% c("none", "increasing", "decreasing") == F)
    stop("Invalid value for sort.means")
  
  # make plot
  
  plot(seq(1, length(resu$means)), resu$means, xaxt = "n",
       xlab = x.title, ylab = y.title, main = main.title,
       xlim = c(0.5, length(resu$means) + 0.5), ylim = c(min(resu$li), max(resu$ls)), 
       pch = 21, col = col, bg = bg, cex = 2)
    
  axis(1, at = seq(1, length(resu$means)), labels = rownames(resu), las = 1)
  
  for (i in 1:length(resu$means)){
    lines(c(i,i), c(resu$li[i], resu$ls[i]), col = col.lines)
  }

}