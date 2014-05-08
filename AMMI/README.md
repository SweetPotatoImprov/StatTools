AMMI
====

Set of functions to run AMMI (Golob, 1968, A Statistical Model which combines Features of Factor Analytic and Analysis of Variance Techniques, *Psychometrika*, Vol 33(1): 73-114).

Function AMMIwithMeans.R
------------------------

Function to compute AMMI from an interaction means matrix. For example, if the data is loaded in an object with name int.mean, the following code will do the job:
```{r eval=F}
source('AMMIwithMeans.R')
AMMIwithMeans(int.mean)
```
