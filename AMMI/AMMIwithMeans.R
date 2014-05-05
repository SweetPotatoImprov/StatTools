###############################################################################
# Function to compute AMMI from an interaction means matrix
# Input: GxE matrix. Genotypes in rows, environments in columns.
# Raul H. Eyzaguirre P.
# 02-05-2014
###############################################################################

AMMIwithMeans <- function(
  int.mean,
  title = "AMMI", # main title and filename
  cex = c(1.2, 1.2, 1.2, 1, 1), # cex main, axis, lab, text, points
  biplot1 = "effects", # Can choose effects or means
  biplot1xlab = NULL, # title for x axis biplot 1
  color = c("red", "blue", "green"), # Env, Gen, Lines
  space = c(0,0,0,0), # limx biplot1 left and right, limx biplot2 left and right
  numrep = 0, # number of replications
  rms = 0, # residual mean square
  rdf = 0, # residual degrees of freedom
  Gsize = 800,
  f = .5,
  pose = 1 # position for text
  )
{
  # Data
	overall.mean <- mean(int.mean)
	env.mean <- apply(int.mean, 2, mean)
	geno.mean <- apply(int.mean, 1, mean)
	env.num <- length(env.mean)
	geno.num <- length(geno.mean)
	svd.mat <- int.mean + overall.mean
	for (i in 1:env.num) svd.mat[,i] <- svd.mat[,i] - geno.mean
	for (i in 1:geno.num) svd.mat[i,] <- svd.mat[i,] - env.mean
	
	# SVD
	PC <- min(env.num, geno.num)-1
	dec <- svd(svd.mat, nu = PC, nv = PC)
	D <- diag(dec$d[1:PC])
	G <- dec$u %*% (D^f)
	E <- dec$v %*% (D^(1-f))
	PC.geno <- cbind(G[,1], G[,2])
	dimnames(PC.geno) <- list(rownames(int.mean), c("PC1", "PC2"))
	PC.env <- cbind(E[,1], E[,2])
	dimnames(PC.env) <- list(colnames(int.mean), c("PC1", "PC2"))
	PC.num <- paste("PC", c(1:PC), sep = "")
	PC.sv <- dec$d[1:PC]^2

  # Contribution of PCs
	PC.cont <- PC.sv/sum(PC.sv)*100
	PC.acum <- cumsum(PC.cont)
	tablaPC <- data.frame(PC = PC.num, SV = PC.sv, Cont = PC.cont, CumCont = PC.acum)
	
	# Significance of PCs, only if numrep, rms and rdf are known
  if (numrep > 0){
    int.SS <- (t(as.vector(svd.mat))%*%as.vector(svd.mat))*numrep
    PC.SS <- (dec$d[1:PC]^2)*numrep
    PC.DF <- env.num + geno.num - 1 - 2*c(1:PC)
    MS <- PC.SS/PC.DF
  }
  if (rms > 0 & rdf >0){
    F <- MS/rms
    probab <- pf(F, PC.DF, rdf, lower.tail=FALSE)
    rowlab <- PC.num
    tablaPC <- cbind(tablaPC, PC.DF, PC.SS, MS, F, probab)
    colnames(tablaPC)[5:9] <- c("df", "SumSq", "MeanSq", "Fvalue", "Pr(>F)")
  }
	  
	#  Biplot 1
  if (biplot1 == "effects"){
    maxx <- max(abs(c(env.mean-overall.mean, geno.mean-overall.mean)))
    limx <- c(-maxx - space[1], maxx + space[2])
    if (is.null(biplot1xlab) == 1)
      xlab = "Genotype and environment effects"
    else
      xlab = biplot1xlab
    xcorg = geno.mean-overall.mean
    xcore = env.mean-overall.mean    
    xline = 0
  }
  if (biplot1 == "means"){
    limx <- range(c(env.mean, geno.mean))
    limx <- limx + c(-abs(limx[1]), abs(limx[2]))*.05 + c(-space[1], space[2])
    if (is.null(biplot1xlab) == 1)
      xlab = "Genotype and environment means"
    else
      xlab = biplot1xlab
    xcorg = geno.mean
    xcore = env.mean
    xline = overall.mean
  }
  limy <- c(-max(abs(c(E[,1], G[,1]))), max(abs(c(E[,1], G[,1]))))
	png(filename = paste(title, "biplot1.png",sep="_"), width = Gsize, height = Gsize)
	par(mar=c(5, 4.5, 4, 2)+.1) 
  plot(1, type = 'n', xlim = limx, ylim = limy, xlab = xlab,
       ylab = paste("PC1 (",format(PC.cont[1],digits=3),"%)"),
       main = paste("AMMI1 biplot - ", title, sep=""),
       cex.axis=cex[2], cex.lab=cex[3], cex.main=cex[1])
	points(xcorg, G[,1], col = color[2], pch=17, cex=cex[5])
	text(xcorg, G[,1], labels = rownames(int.mean), col = color[2], cex=cex[4], pos=1, offset=0.3)
	points(xcore, E[,1], col = color[1], pch=15, cex=cex[5])
	text(xcore, E[,1], labels = colnames(int.mean), col = color[1], cex=cex[4], pos=pose, offset=.4)
	abline(h = 0, v = xline, col=color[3], lty = 2)
	dev.off()
	
	# Biplot 2
	limx <- range(c(E[,1], G[,1]))
	limx <- limx + c(-abs(limx[1]), abs(limx[2]))*.05 + c(-space[3], space[4])
	limy <- range(c(E[,2], G[,2]))
	png(filename = paste(title, "biplot2.png", sep="_"), width = Gsize, height = Gsize)
	par(mar=c(5, 4.5, 4, 2)+.1) 
  plot(1, type = 'n', xlim = limx, ylim = limy,
       xlab = paste("PC1 (",format(PC.cont[1],digits=3),"%)"),
       ylab = paste("PC2 (",format(PC.cont[2],digits=3),"%)"),
       main = paste("AMMI2 biplot - ", title, sep=""),
       cex.axis=cex[2], cex.lab=cex[3], cex.main=cex[1], asp=1)
	points(G[,1], G[,2], col = color[2], pch=17, cex=cex[5])
	text(G[,1], G[,2], labels = rownames(int.mean), col = color[2], cex=cex[4], pos=1, offset=.3)
	points(E[,1], E[,2], col = color[1], pch=15, cex=cex[5])
	text(E[,1], E[,2], labels = colnames(int.mean), col = color[1], cex=cex[4], pos=1, offset=.3)
	abline(h = 0, v = 0, col=color[3], lty = 2)
	for (i in 1:env.num) lines(c(0,E[i,1]), c(0,E[i,2]), col=color[1], lty=3)
	dev.off()
	
	list(
			PC_values_genotypes = PC.geno,
			PC_values_environments = PC.env,
			Contribution_PCs = tablaPC
	)
}