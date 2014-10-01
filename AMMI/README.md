AMMI.R
------

### Description
Set of functions to run AMMI (Gollob, H. R., 1968).
Function `AMMI` runs AMMI from data at plot level and function `AMMIwithMeans` runs AMMI from
an interaction means matrix.

### Usage

```{r eval=F}
AMMI(trait, geno, env, rep, data, f = 0.5, biplot = 1, biplot1 = "effects",
     title = NULL, xlab = NULL, color = c("darkorange", "black", "gray"), ...)
```
```{r eval=F}
AMMIwithMeans(int.mean, trait = NULL, rep.num = NULL, rdf = NULL, rms = NULL, f = 0.5,
              biplot = 1, biplot1 = "effects", title = NULL, xlab = NULL,
              color = c("darkorange", "black", "gray"), ...)
```
### Arguments

```
trait      : Trait to analyze.
geno       : Genotypes.
env        : Environments.
rep        : Replications or blocks. A RCBD is assumed.
data       : Data frame containing the data.
int.mean   : GxE means matrix. Genotypes in rows, environments in columns.
rep.num    : Number of replications.
rdf        : Residual degrees of freedom.
rms        : Residual mean square.
f          : Scaling factor, defaults to 0.5.
biplot     : 1 for the trait-PC1 biplot and 2 for the PC1-PC2 biplot.
biplot1    : Choose "effects" or "means" for biplot1.
title      : Main title for biplot1 or biplot2.
xlab       : Xlab for biplot1.
color      : Color for lines, symbols and names for environments, genotypes and axes.
...        : Additional graphic parameters.
```

### Details
Significance of PCs are evaluated with function `AMMI` only if the data are balanced.
With funcion `AMMIwithMeans` the significance of PCs is evaluated only if `rep.num`,
`rms` and `rdf` are specified.

### Value
It returns the first and second PC values for genotypes and environments, a table with the
contribution of each PC, a dispersion plot of means or effects against the first PC, or a
dispersion plot of PC1 against PC2.
Significance of PCs are included in the contributions table only if `rep.num`, `rms` and `rdf`
are specified.

### Example

Run the following code to load all the functions:

```{r eval=F}
urlfile <- "https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/AMMI/AMMI.R"
source(urlfile)
```

If data for a MET in a RCBD is loaded in a data frame with name `mydata`
containing a column for trait root yield (`RYTHA`) and columns with names `geno`, `env`,
and `rep`, the following code will do the job (accepting all the defaults):
```{r eval=F}
AMMI("RYTHA", "geno", "env", "rep", mydata)
```

If the GxE means are loaded in an object with name `int.mean`, the following code will do the job
(accepting all the defaults):
```{r eval=F}
AMMIwithMeans(int.mean)
```

### References

* Gollob, H. R. (1968). A Statistical Model which combines Features of Factor Analytic and Analysis
of Variance Techniques, *Psychometrika*, Vol 33(1): 73-114.
