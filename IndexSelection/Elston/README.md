Elston.R
--------

### Description

Function to compute the Elston index.

### Usage

```{r eval=F}
Elston(traits, geno, data, lb = 1)
```
### Arguments

```
traits : List of traits.
geno   : Genotypes.
data   : Data frame containing the data.
lb     : Lower bound. 1 for k = min(x) and 2 for k = (n*min(x) - max(x))/(n-1)
```

### Details

The Elston index (Elston, R. C., 1963) is a weight free index.

### Value

It returns:
```
Elston.Index        : The Elston index value.
Sorted.Elston.Index : The Elston index value sorted in descending order.
```

### Example

```{r eval=F}
# Download the data file SI_example_small.csv. This works well with RStudio.
urlfile <- "https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/
IndexSelection/Presentation/SI_example_small.csv"
mydata <- read.csv(urlfile)

# Make a subset for one location.
mydata <- subset(mydata, LOC=="Satipo")
```
This file contains data for traits total root yield (`RYTHA`), beta carotene (`BC`), dry matter content (`DM`),
starch (`STAR`), and number of commercial roots (`NOCR`), and columns with names `GENO`, and `REP`,
to identify the genotypes and replications. The following code computes the Elston index
accepting all the defaults:
```{r eval=F}
# Download the Elston.R function. This works well with RStudio.
urlfile <- "https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/
IndexSelection/Elston/Elston.R"
source(urlfile)

# Run the function.
Elston(c("RYTHA", "BC", "DM", "STAR", "NOCR"), "GENO", mydata)
```

### References

* Elston, R. C. (1963). A weight-free index for the purpose of ranking or selection with respect
  to several traits at a time. *Biometrics*. 19(1): 85-97.
