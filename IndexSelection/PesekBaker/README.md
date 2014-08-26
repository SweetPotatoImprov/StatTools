PesekBaker.R
------------

### Description

Function to compute the Pesek-Baker index.

### Usage

```{r eval=F}
PesekBaker(traits, geno, env, rep, data, dgg = NULL, units = "sdu", sf = 0.1)
```
### Arguments

```
traits : List of traits.
geno   : Genotypes.
env    : Environments.
rep    : Replications or blocks.
data   : Data frame containing the data.
dgg    : Desired genetic gains, defaults to one standard deviation.
units  : Units for dgg, "actual" or "sdu". See details for more information. 
sf     : Selected fraction, defaults to 0.1.
```

### Details

The Pesek Baker (Pesek, J. and R.J. Baker., 1969) is an index where relative economic weights have been
replaced by desired gains.

If `dgg` is not specified, the standard deviations of the traits are used. It means that
the desired genetic gain is equal to one standard deviation for each trait. `dgg` can be specified
in actual units (`actual`) or in standard deviations (`sdu`), defaults to `sdu`.
For example, if you have a trait which is expressed in kilograms and with a standard deviation of
5 kilograms, putting `dgg` equal to 2 means a desired genetic gain of 2 standard deviations, that
is, 10 kilograms. If you put `dgg` equal to 2 and `units` equal to `actual` then this means a desired
genetic gain of 2 kilograms. If `dgg` is leave as `NULL` then the desired genetic
gain will be one standard deviation, which is 5 kilograms, no matter if `units` is set as `actual`
or `sdu`.

To compute the index the package `lme4` is needed. If it is not installed by sourcing the
`PesekBaker.R` file you will be asked to install the package and dependencies.

### Value

It returns:
```
Desired.Genetic.Gains     : The desired genetic gains in actual units.
Standard.Deviations       : The estimated standard deviations.
Genetic.Variances         : The estimated genetic variances.
Correlation.Matrix        : The estimated correlation matrix.
Index.Coefficients        : The index coefficients.
Response.to.Selection     : The response to selection.
Std.Response.to.Selection : The standardized response to selection.
Pesek.Baker.Index         : The Pesek-Baker index value.
Sorted.Pesek.Baker.Index  : The Pesek-Baker index value sorted in descending order.
```

### Example

```{r eval=F}
## Download the data file SI_example_small.csv. This works well with RStudio.
urlfile <- "https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/
IndexSelection/Presentation/SI_example_small.csv"
mydata <- read.csv(urlfile)
```
This file contains data for traits total root yield (`RYTHA`), beta carotene (`BC`), dry matter content (`DM`),
starch (`STAR`), and number of commercial roots (`NOCR`), and columns with names `GENO`, `LOC`, and `REP`,
to identify the genotypes, locations and replications. The following code computes the Pesek-Baker index
accepting all the defaults:
```{r eval=F}
## Download the PesekBaker.R function. This works well with RStudio.
urlfile <- "https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/
IndexSelection/PesekBaker/PesekBaker.R"
source(urlfile)

## Run the function.
PesekBaker(c("RYTHA", "BC", "DM", "STAR", "NOCR"), "GENO", "LOC", "REP", mydata)
```

### References

* Pesek, J. and R.J. Baker.(1969). Desired improvement in relation to selection indices.
  *{Can. J. Plant. Sci.}* 9:803-804.