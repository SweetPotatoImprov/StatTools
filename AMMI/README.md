AMMI.R
------

### Description
Set of functions to run AMMI (Gollob, H. R., 1968).
Function `AMMI` runs AMMI from data at plot level and function `AMMIwithMeans` runs AMMI from
an interaction means matrix.

### Usage

```{r eval=F}
AMMI(trait, geno, env, rep, data, f = 0.5, biplot1 = "effects",
     title1 = NULL, title2 = NULL, file.name1 = NULL, file.name2 = NULL,
     color = c("darkorange", "black", "gray"), Gsize = 600, ...)
```
```{r eval=F}
AMMIwithMeans(int.mean, rep.num = 0, rdf = 0, rms = 0, f = 0.5, biplot1 = "effects",
              title1 = NULL, title2 = NULL, file.name1 = NULL, file.name2 = NULL,
              color = c("darkorange", "black", "gray"), Gsize = 600, ...)
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
biplot1    : Choose 'effects' or 'means' for biplot1.
title1     : Main title for biplot1.
title2     : Main title for biplot2.
file.name1 : File name for biplot1.
file.name2 : File name for biplot2.
color      : Color for lines, symbols and names for environments, genotypes and axes.
Gsize      : Graphic size.
...        : Additional graphic parameters.
```

### Details
Significance of PCs are evaluated with function `AMMI` only if the data are balanced.
With funcion `AMMIwithMeans` the significance of PCs is evaluated only if `rep.num`,
`rms` and `rdf` are specified.

### Value
It returns the first and second PC values for genotypes and environments, a table with the
contribution of each PC, a dispersion plot of means or effects against the first PC, and a
dispersion plot of PC1 against PC2. Both plots are saved in the working directory as png files.
Significance of PCs are included in the contributions table only if `rep.num`, `rms` and `rdf`
are specified.

### Example

Run the following code to load all the functions:

```{r eval=F}
source('AMMI.R')
```

If data for a MET in a RCBD is loaded in a data frame with name `field.data`
containing a column for trait root yield (`RYTHA`) and columns with names `geno`, `env`,
and `rep`, the following code will do the job (accepting all the defaults):
```{r eval=F}
AMMI('RYTHA', 'geno', 'env', 'rep', field.data)
```

If the GxE means are loaded in an object with name `int.mean`, the following code will do the job
(accepting all the defaults):
```{r eval=F}
AMMIwithMeans(int.mean)
```

### References

* Gollob, H. R. (1968). A Statistical Model which combines Features of Factor Analytic and Analysis
of Variance Techniques, *Psychometrika*, Vol 33(1): 73-114.
