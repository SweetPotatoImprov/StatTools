Elston.R
--------

### Description

Function to compute the Elston index.

### Usage

```{r eval=F}
Elston(traits, geno, data, lb=1)
```
### Arguments

```
traits : List of traits.
geno   : Genotypes.
data   : Data frame containing the data.
lb     : Lower bound. 1 for k=min(x) and 2 for k=(n*min(x) - max(x))/(n-1)
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

If data is loaded in a data frame with name `mydata` containing traits total root yield (`RYTHA`),
total biomass (`BIOM`), harvest index (`HI`), and dry matter (`DM`), and a column with name
`geno` for genotypes, the following code will do the job (accepting the defaults):
```{r eval=F}
source('Elston.R')
Elston(c('RYTHA', 'BIOM', 'HI', 'DM'), 'geno', mydata)
```

### References

* Elston, R. C. (1963). A weight-free index for the purpose of ranking or selection with respect
  to several traits at a time. *Biometrics*. 19(1): 85-97.
