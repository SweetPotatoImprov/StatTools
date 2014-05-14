MissValEst.R
------------

### Description

Functions to estimate missing values.
Function `mve.rcbd` estimates missing values for a Randomized Complete Block Design (RCBD) and
function `mve.rcbd.met` estimates missing values for a Multi Environment Trial (MET) with a RCBD.

### Usage

```{r eval=F}
mve.rcbd(trait, geno, rep, data, maxp=0.05, tol=1e-06)
```
```{r eval=F}
mve.rcbd.met(trait, geno, env, rep, data, maxp=0.05, tol=1e-06)
```

### Arguments

```
trait : Trait to estimate missing values.
geno  : Genotypes.
env   : Environments.
rep   : Replications or blocks.
data  : Data frame containing the data.
maxp  : Maximum allowed proportion of missing values to estimate, defaults to 5%. 
tol   : Tolerance for the convergence of the iterative estimation process.
```

### Details

A `data.frame` with data for a RCBD or a MET in a RCBD with at least two replications
and at least one datum for each treatment must be loaded. Experimental data
with only one replication, any treatment without data, or more missing values than
specified in `maxp` will generate an error message.

### Value

It returns a data frame with name `new.data` and the number `est.num` and proportion `est.prop`
of estimated missing values.  The `new.data` data frame contains the experimental layout and
columns `trait` and `trait.est` with the original data and the original data plus the
estimated values.

### Example

Run the following code to load all the functions:

```{r eval=F}
source('MissValEst.R')
```

If data for a single RCBD is loaded in a data frame with name `field.data` containing a
column for trait root yield (`RYTHA`) and columns with names `geno` and `rep`, the following
code will do the job (accepting all the defaults):
```{r eval=F}
mve.rcbd("RYTHA", "geno", "rep", field.data)
```

Similarly if data for a MET in a RCBD is loaded in a data frame with name `field.data`
containing a column for trait root yield (`RYTHA`) and columns with names `geno`, `env`,
and `rep`, the following code will do the job (accepting all the defaults):
```{r eval=F}
mve.rcbd.met("RYTHA", "geno", "env", "rep", field.data)
```
