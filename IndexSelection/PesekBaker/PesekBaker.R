###############################################################################
# PeseK Baker Index
# Raul H. Eyzaguirre P.
###############################################################################

## packages

checkPkgs <- function() {
  pkgs <- c("lme4", "Rcpp")
  have.pkg <- pkgs %in% .packages(all.available = TRUE)
  
  if(any(!have.pkg)) {
    cat("Some packages need to be installed\n")
    r <- readline("Install necessary packages [y/n]? ")
    if(tolower(r) == "y") {
      need <- pkgs[!have.pkg]
      message("installing packages ",
              paste(need, collapse = ", "))
      install.packages(need)
    }
  }
}

checkPkgs()

require(lme4)

PesekBaker <- function(..., geno, env, rep, data, dgg=NULL, sf=0.1) {
  
  ## inits
  
  gv <- NULL # genetic variance
  pv <- NULL # phenotipic variance
  nt <- length(list(...)) # number of traits
  ng <- nlevels(factor(data[,geno])) # number of genotypes
  ne <- nlevels(factor(data[,env])) # number of environments
  nr <- nlevels(factor(data[,rep])) # number of replications in each environment
  rs <- NULL # response to selection
  
  ## fitted models by REML  

  for (i in 1:nt){
    abc <- data.frame(c1=data[,list(...)[[i]]], c2=data[,geno], c3=data[,env], c4=data[,rep])
    model <- lmer(c1 ~ (1|c2) + (1|c2:c3) + (1|c3/c4), data=abc)
    gv[i] <- VarCorr(model)$c2[1]
    pv[i] <- VarCorr(model)$c2[1] + VarCorr(model)$'c2:c3'[1]/ne +
      attr(VarCorr(model), "sc")^2/ne/nr
  }    
  
## compute correlation and covariance matrices
  
  df <- data[,c(sapply(list(...), c), env, rep)] 
  df <- split(df, factor(paste(data[,env], data[,rep]))) # split by env and rep
  corr <- cor(df[[1]][,1:nt], use="pairwise.complete.obs")
  for (i in 2:length(df))
    corr <- corr + cor(df[[i]][,1:nt], use="pairwise.complete.obs")
  corr <- corr/length(df)
  S <- diag(gv^.5, nt, nt)
  G <- S%*%corr%*%S
  dimnames(G) <- dimnames(corr)
  P <- G
  diag(P) <- pv
  
  ## compute index coefficients
  
  if (is.null(dgg)==TRUE) dgg <- gv^.5
  b <- solve(G)%*%dgg
  dimnames(b) <- list(dimnames(corr)[[1]], "coef")
  
  ## response to selection
  
  si <- dnorm(qnorm(1-sf))/sf # selection intensity
  bPb <- t(b)%*%P%*%b
  for (i in 1:nt)
    rs[i] <- si * t(b)%*%G[,i]/sqrt(bPb*G[i,i])
  rsa <- rs * gv^.5 # response to selection in actual units
  
  ## index calculation
  
  m <- matrix(NA, ng, nt)
  for (i in 1:nt)
    m[,i] <- tapply(data[,list(...)[[i]]], data[,geno], mean, na.rm=T)
  indices <- m %*% b
  rownames(indices) <- levels(data[,geno])
  colnames(indices) <- "PesekBakerIndex"
  orden <- order(indices, decreasing = T)
  sort.ind <- indices
  sort.ind[,1] <- indices[orden]
  rownames(sort.ind) <- levels(data[,geno])[orden]
  colnames(sort.ind) <- "PesekBakerIndex"
  
  ## results
  list(Genetic.Variance=gv, Correlation.Matrix=corr, Covariance.Matrix=G, Index.Coefficients=b,
       Std.Response.to.Selection=rs, Response.to.Selection=rsa,
       Pesek.Baker.Index=indices, Sorted.Pesek.Baker.Index=sort.ind)
}