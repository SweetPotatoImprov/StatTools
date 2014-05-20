Tai.R
------

### Description

Function to run the Tai stability analysis (Tai, G. C. C., 1971).

### Usage

```{r eval=F}
Tai(trait, geno, env, rep, data, conf=0.95, title = NULL, file.name = NULL,
    color = c("darkorange", "black", "gray"), Gsize = 600, ...)
```

### Arguments

```
trait     : Trait to analyze.
geno      : Genotypes.
env       : Environments.
rep       : Replications or blocks. A RCBD is assumed.
data      : Data frame containing the data.
conf      : Probability for the Tai limits.
title     : Main title for plot.
file.name : File name for plot.
color     : Color for symbols, names and lines.
Gsize     : Graphic size.
...       : Additional graphic parameters.
```

### Details
The limits for alpha and lambda are computed using the mean squares from an ANOVA table for
a RCBD with blocks nested into environments. If the data set is unbalanced, a warning is produced.

### Value
It returns the Tai graph for stability analysis and the values of alpha and lambda for each
genotype. The plot is saved in the working directory as a png file.

### Example

Run the following code to load all the necessary functions:

```{r eval=F}
source('Tai.R')
```

If data for a MET in a RCBD is loaded in a data frame with name `field.data`
containing a column for trait root yield (`RYTHA`) and columns with names `geno`, `env`,
and `rep`, the following code will do the job (accepting all the defaults):
```{r eval=F}
Tai(RYTHA, geno, env, rep, field.data)
```

### References

* Tai, G. C. C. (1971). Genotypic Stability Analysis and Its Application to Potato Regional Trials,
*Crop Science*, Vol 11.
  