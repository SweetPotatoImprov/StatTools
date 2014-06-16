PesekBaker.R
------------

### Description

Function to compute the Pesek-Baker index.

### Usage

```{r eval=F}
PesekBaker(traits, geno, env, rep, data, dgg=NULL, sf=0.1)
```
### Arguments

```
traits : List of traits.
geno   : Genotypes.
env    : Environments.
rep    : Replications or blocks.
data   : Data frame containing the data.
dgg    : Desired genetic gains, defaults to standard deviations.
sf     : Selected fraction, defaults to 0.1.
```

### Details

The Pesek Baker (Pesek, J. and R.J. Baker., 1969) is an index where relative economic weights have been
replaced by desired gains.

If `dgg` is not specified, the standard deviations of the traits are used. It means that
the desired genetic gain is equal to one standard deviation for each trait.

To compute the index the package `lme4` is needed. If it is not installed by sourcing the
`PesekBaker.R` file you will be asked to install the package.

### Value

It returns:
```
Genetic.Variance          : The estimated genetic variances.
Correlation.Matrix        : The estimated correlation matrix.
Covariance.Matrix         : The estimated covariance matrix.
Index.Coefficients        : The index coefficients.
Std.Response.to.Selection : The standardized response to selection.
Response.to.Selection     : The response to selection.
Pesek.Baker.Index         : The Pesek-Baker index value.
Sorted.Pesek.Baker        : The Pesek-Baker index value sorted in descending order.
```

### Example

If data is loaded in a data frame with name `field.data` containing traits total root yield (`RYTHA`),
total biomass (`BIOM`), harvest index (`HI`), and dry matter (`DM`), and columns with names
`geno`, `env`, and `rep`, the following code will do the job (accepting all the defaults):
```{r eval=F}
source('PesekBaker.R')
PesekBaker(c('RYTHA', 'BIOM', 'HI', 'DM'), 'geno', 'env', 'rep', field.data)
```

### References

* Pesek, J. and R.J. Baker.(1969). Desired improvement in relation to selection indices.
  *{Can. J. Plant. Sci.}* 9:803-804.