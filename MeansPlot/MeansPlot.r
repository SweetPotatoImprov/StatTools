###############################################################################
# Function to plot means and confidence limits.
# Raul H. Eyzaguirre P.
###############################################################################

MeansPlot <- function(trait, groups, data, conf = 0.95, file.name = "MeansPlot",
                     main.title = "", x.title = "groups", y.title = "",
                     col = "black", bg = "darkorange", col.lines = "black",
                     width = 480, height = 480){
  
  # means and standard deviations
  
  means <- tapply(data[,trait], data[,groups], mean, na.rm=T)
  sdev <- tapply(data[,trait], data[,groups], sd, na.rm=T)
  
  # compute confidence intervals
  
  n <- tapply(is.na(data[, trait])==0, data[,groups], sum)
  li <- means - qt((1 + conf)/2, n) * sdev/sqrt(n)
  ls <- means + qt((1 + conf)/2, n) * sdev/sqrt(n)
  
  # make plot
  
  png(filename = paste(file.name, '.png', sep=""), width = width, height = height)
  
  plot(seq(1, length(means)), means, xaxt = "n",
       xlab = x.title, ylab = y.title, main = main.title,
       xlim = c(0.5, length(means) + 0.5), ylim = c(min(li), max(ls)), 
       pch = 21, col = col, bg = bg, cex = 2)
    
  axis(1, at = seq(1, length(means)), labels = levels(as.factor(data[,groups])), las = 1)
  
  for (i in 1:length(means)){
    lines(c(i,i), c(li[i], ls[i]), col = col.lines)
  }

  dev.off()
}