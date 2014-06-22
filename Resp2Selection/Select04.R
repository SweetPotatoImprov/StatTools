###############################################################################
# Response to selection with several locations in two steps
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

require(gWidgetsRGtk2)
require(cairoDevice)
options("guiToolkit"="RGtk2")

## number of genotypes at begining

pcList <- list(type="fieldset", label = "Number of genotypes for stage 1", columns = 1,
		children = list(
				list(name = "g", type = "gedit", text = "", coerce.with = as.numeric)
		)
)

## selection at stage 1

st1List <- list(type = "fieldset", label = "Selection at stage 1", label.pos = "top", columns = 3,
		children = list(
				list(name = "k1", label = "Number of locations", type = "gedit", text = "", coerce.with = as.numeric),
				list(name = "r1", label = "Number of replications", type="gedit", text = "", coerce.with = as.numeric),
				list(name = "sg1", label = "Selected genotypes", type="gedit", text="", coerce.with = as.numeric)
		)
)

## selection at stage 2

st2List <- list(type = "fieldset", label = "Selection at stage 2", label.pos = "top", columns = 3,
		children = list(
				list(name = "k2", label = "Number of locations", type = "gedit", text = "", coerce.with = as.numeric),
				list(name = "r2", label = "Number of replications", type="gedit", text = "", coerce.with = as.numeric),
				list(name = "sg2", label = "Selected genotypes", type="gedit", text="", coerce.with = as.numeric)
		)
)

## variances

varList <- list(type = "fieldset", label = "Variance components", label.pos = "top", columns = 3,
		children = list(
				list(name = "sigmaG2", label = "G", type = "gedit", text = "", coerce.with = as.numeric),
				list(name = "sigmaGL2", label = "GxL", type="gedit", text = "", coerce.with = as.numeric),
				list(name = "sigmaGY2", label = "GxY", type="gedit", text = "", coerce.with = as.numeric),
				list(name = "sigmaGLY2", label = "GxLxY", type="gedit", text = "", coerce.with = as.numeric),
				list(name = "sigmaE2", label = "Error", type="gedit", text="", coerce.with = as.numeric)
		)
)

## selection gain list

selectiongain <- list(type = "ggroup",
		horizontal = FALSE,
		children = list(
				pcList,
				st1List,
				st2List,
				varList
		)
)

## Code to call the layout

w <- gwindow("Response to selection with several locations in two steps")
gg <- ggroup(horizontal = FALSE, cont = w)
fl <- gformlayout(selectiongain, cont = gg, expand=TRUE)
bg <- ggroup(cont = gg)
addSpring(bg)
b <- gbutton("Compute", cont = bg)
outputArea <- gtext(container=gg, font.attr=c(family="monospace"))

## computations

select <- function(g, k1, r1, sg1, k2, r2, sg2, sigmaG2, sigmaGL2, sigmaGY2, sigmaGLY2, sigmaE2){

  # first stage
	
  alpha1 <- sg1/g
	x1 <- qnorm(1-alpha1) # truncation point on the N(0,1) for the selected fraction
	z1 <- dnorm(x1)
	i1 <- z1/alpha1
	rho1 <- sqrt(sigmaG2 / (sigmaG2 + sigmaGL2/k1 + sigmaGY2 + sigmaGLY2/k1 + sigmaE2/k1/r1))
	R1 <- i1*rho1
	
  # second stage
	
  alpha2 <- sg2/sg1
	rho2 <- sqrt(sigmaG2 / (sigmaG2 + sigmaGL2/k2 + sigmaGY2 + sigmaGLY2/k2 + sigmaE2/k2/r2))
	
  # both togheter
	
  alpha <- alpha1*alpha2
	rho <- rho1*rho2
	int <- function(x){
		(2*pi)^(-.5)*exp(-x^2/2) * pnorm((x1-rho*x)/(sqrt(1-rho^2)), lower.tail=FALSE)
	}
	f <- function(t){
		integrate(int, t, Inf)$value - alpha
	}
	x2 <- uniroot(f, c(0,20))$root # truncation point on the N(0,1) for the selected fraction
	z2 <- dnorm(x2) 
	a <- (x1 - rho*x2)/sqrt(1-rho^2)
	b <- (x2 - rho*x1)/sqrt(1-rho^2)
	I1 <- 1 - pnorm(a)
	I2 <- 1 - pnorm(b)
	R2 <- (rho1*z1*I2 + rho2*z2*I1)/alpha
	salida <- data.frame(row.names=c("1st stage =", "2nd stage ="))
	salida$x <- c(x1,x2)
	salida$Ru <- c(R1,R2)
	salida
}

addHandlerChanged(b, function(h,...) {
			out <- capture.output(do.call("select",svalue(fl)))
			dispose(outputArea)
			if(length(out)>0)
				add(outputArea, out)
		})
