Tai.R
------

### Description

Function to run the Tai stability analysis (Tai, G. C. C., 1971).

### Usage

```{r eval=F}
Tai(trait, geno, env, rep, data, conf = 0.95, title = NULL,
    color = c("darkorange", "black", "gray"), ...)
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
color     : Color for symbols, names and lines.
...       : Additional graphic parameters.
```

### Details
The limits for alpha and lambda are computed using the mean squares from an ANOVA table for
a RCBD with blocks nested into environments. If the data set is unbalanced, a warning is produced.

### Value
It returns the Tai graph for stability analysis and the values of alpha and lambda for each
genotype.

### Example

```{r eval=F}
# Load the Tai.R function in R (this works with RStudio)
urlfile <- "https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/Tai/Tai.R"
source(urlfile)

# Load the data
urlfile <- "https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/AMMI/METdata.dat"
mydata <- read.table(urlfile, header=T)

# Run Tai for trait y
Tai("y", "geno", "env", "rep", mydata)
```

### References

* Tai, G. C. C. (1971). Genotypic Stability Analysis and Its Application to Potato Regional Trials,
*Crop Science*, Vol 11.
  