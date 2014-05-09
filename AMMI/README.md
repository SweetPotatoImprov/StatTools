AMMI
====

Set of functions to run AMMI (Golob, 1968, A Statistical Model which combines Features of Factor Analytic and Analysis of Variance Techniques, *Psychometrika*, Vol 33(1): 73-114).

AMMIwithMeans.R
---------------

### Description
Function to compute AMMI from an interaction means matrix.

### Usage

```{r eval=F}
AMMIwithMeans(int.mean, numrep = 0, rms = 0, rdf = 0, f = .5,
              title = "AMMI", biplot1 = "effects", biplot1xlab = NULL,
              color = c("red", "blue", "green"), Gsize = 800)
```
### Arguments

```
int.mean    : GxE means matrix. Genotypes in rows, environments in columns.
numrep      : Number of replications.
rms         : Residual mean square.
rdf         : Residual degrees of freedom.
f           : Scaling factor, defaults to 0.5.
title       : Main title and filename for plots.
biplot1     : Choose effects or means for biplot1.
biplot1xlab : Title for x axis biplot 1.
color       : Color for lines for environments, genotypes and axes.
Gsize       : Graphic size.
```

### Details
Significance of PCs are evaluated only if `numrep`, `rms` and `rdf` are specified.

### Value
It returns the first and second PC values for genotypes and environments, a table with the
contribution of each PC, a dispersion plot of means or effects against the first PC, and a
dispersion plot of PC1 against PC2. Both plots are saved in the working directory as png files.
Significance of PCs are included in the contributions table only if `numrep`, `rms` and `rdf`
are specified.

### Example

If data is loaded in an object with name int.mean, the following code will do the job (accepting all the defaults):
```{r eval=F}
source('AMMIwithMeans.R')
AMMIwithMeans(int.mean)
```

