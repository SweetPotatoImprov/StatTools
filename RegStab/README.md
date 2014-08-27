RegStab.R
---------

### Description

Function to run the regression stability analysis (Yates and Cochran, 1938, Finlay and Wilkinson, 1963).
This implementation follows the formulas of Eberhart and Russell (1966).

### Usage

```{r eval=F}
RegStab(trait, geno, env, rep, data, maxp = 0.05)
```

### Arguments

```
trait : Trait to analyze.
geno  : Genotypes.
env   : Environments.
rep   : Replications or blocks.
data  : Data frame containing the data.
maxp  : Maximum allowed proportion of missing values to estimate, defaults to 5%. 
```

### Details

The regression stability analysis is evaluated with a balanced data set.
If data is unbalanced, missing values are estimated up to an specified maximum proportion,
5% by default.

To run a regression stability analysis you need a set of genotypes evaluated in a set of environments.
At least 3 genotypes or environments are needed. In a regression stability analysis for genotypes
grown at several environments, for each genotype a simple linear regression of individual yield (Y)
on the mean yield of all genotypes for each environment (X) is fitted. In a similar way, for each
environment, a simple linear regression of individual yield (Y) on the mean yield of all environments
for each genotype (X) is fitted.

### Value

It returns the regression stability analysis for genotypes and environments.
It also returns the coefficient of variation.

### Example

Run the following code to load the function:

```{r eval=F}
source("RegStab.R")
```

If data for a MET in a RCBD is loaded in a data frame with name `mydata`
containing a column for trait root yield (`RYTHA`) and columns with names `geno`, `env`,
and `rep`, the following code will run the regression stability analysis accepting all the defaults:
```{r eval=F}
RegStab("RYTHA", "geno", "env", "rep", mydata)
```

### References

* Eberhart, S. A. and Russell, W. A. (1966). Stability Parameters for Comparing Varieties.
*Crop Sci.* 6: 36-40.
* Finlay, K. W., and Wilkinson, G. N. (1963). The Analysis of Adaption in a Plant-Breeding Programme.
*Aust. J. Agric. Res.* 14: 742-754.
* Yates, F., and Cochran, W. G. (1938). The Analysis of Group Experiments.
*J. Agric. Sci.* 28: 556-580.  
