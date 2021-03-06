###############################################################################
# Response to selection for a single experiment
# Raul H. Eyzaguirre P.
###############################################################################

## packages

checkPkgs <- function() {
  required <- c("gWidgetsRGtk2", "cairoDevice")
  installed <- required %in% .packages(all.available = TRUE)
  if(any(!installed)) {
    cat("Some packages need to be installed\n")
    r <- readline("Install necessary packages [y/n]? ")
    if(tolower(r) == "y") {
      message("installing packages ",
              paste(required[!installed], collapse = ", "))
      install.packages(required[!installed])
    }
  }
}

checkPkgs()

library(gWidgetsRGtk2)
library(cairoDevice)
options("guiToolkit"="RGtk2")

## Drawing function

updatePlot <- function(h,...) {
	r <- seq(1,floor(svalue(N)/svalue(sg1)),1)
	g <- floor(svalue(N)/r)
	alpha <- svalue(sg1)/g
	z <- dnorm(qnorm(1-alpha))
	i <- z/alpha
	rho <- sqrt(svalue(sigmaG2) / (svalue(sigmaG2) + svalue(sigmaE2)/r))
	R <- i*rho
	plot(r, R, xlab="Number of replications", ylab="Response to selection", type="b")
	points(r[match(max(R),R)], max(R), col = "red", pch=18)
	mtext(paste("Optimum number of replications = ", r[match(max(R),R)]), line=2.9)
	mtext(paste("Number of genotypes at optimum = ", g[match(max(R),R)]), line=1.7)
	mtext(paste("Response to selection at optimum = ", round(max(R),2)), line=0.5)
}

## Widgets

N <- gspinbutton(from=100, to=10000, by=100, value=1000, handler = updatePlot) # Plot capacity
sg1 <- gspinbutton(from=1, to=10000, by=10, value=10, handler = updatePlot) # selected genotypes
sigmaG2 <- gspinbutton(from=0.001, to=1000, by=0.1, value=1, digits=3, handler = updatePlot) # Genotypic variance
sigmaE2 <- gspinbutton(from=0.001, to=1000, by=0.1, value=1, digits=3, handler = updatePlot) # Error variance

## Layout

window <- gwindow("Response to selection for a single experiment")
BigGroup <- ggroup(cont=window)
group <- ggroup(horizontal=FALSE, container=BigGroup)
tmp <- gframe("Plot capacity", container=group)
add(tmp, N)
tmp <- gframe("Number of selected genotypes", container=group)
add(tmp, sg1)
tmp <- gframe("Genotypic variance", container=group)
add(tmp, sigmaG2)
tmp <- gframe("Error variance", container=group)
add(tmp, sigmaE2)

## Graphics device

add(BigGroup, ggraphics())
