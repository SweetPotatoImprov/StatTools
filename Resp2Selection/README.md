Resp2Selection
--------------

Set of scripts to find the optimum number of replications to get the maximum response to selection.

### Select01.R

Response to selection for a single experiment. 

It finds the optimum number of replications to get the maximum response to selection and computes the response to selection at this optimum value for a given plot capacity, number of selected genotypes, genotypic variance and error variance. To run the script just save it in the working directory and read it as shown below:
```{r eval=F}
source("Select01.R")
```
With RStudio you can load the script directly from the URL:
```{r eval=F}
source("https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/Resp2Selection/Select01.R")
```

### Select02.R

Response to selection with several locations.

It finds the optimum number of replications to get the maximum response to selection and computes the response to selection at this optimum value for a given plot capacity, number of locations, number of selected genotypes, genotypic variance, genotypic by location variance, and error variance. To run the script just save it in the working directory and read it as shown below:
```{r eval=F}
source("Select02.R")
```
With RStudio you can load the script directly from the URL:
```{r eval=F}
source("https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/Resp2Selection/Select02.R")
```

### Select03.R

Response to selection with several locations and years.

It finds the optimum number of replications to get the maximum response to selection and computes the response to selection at this optimum value for a given plot capacity, number of locations, number of years, number of selected genotypes, genotypic variance, genotypic by location variance, genotypic by year variance, genotypic by location by year variance, and error variance. To run the script just save it in the working directory and read it as shown below:
```{r eval=F}
source("Select03.R")
```
With RStudio you can load the script directly from the URL:
```{r eval=F}
source("https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/Resp2Selection/Select03.R")
```

### Select04.R

Response to selection with several locations in two steps (two years).

It computes the response to selection for each step in a two steps selection with several locations for a given number of genotypes at stage 1, the number of locations, replications and selected genotypes at stage 1, the number of locations, replications and selected genotypes at stage 2, and the genotypic, genotypic by location, genotypic by year, genotypic by location by year, and error variances. To run the script just save it in the working directory and read it as shown below:
```{r eval=F}
source("Select04.R")
```
With RStudio you can load the script directly from the URL:
```{r eval=F}
source("https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/Resp2Selection/Select04.R")
```
