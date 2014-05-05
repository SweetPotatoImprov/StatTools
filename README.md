BreederTools
============

R code for the analysis of field experiments data.

CheckConsis
-------------------------

Set of rules to check for consistency of data in R.

1. Load the data in an object with name datos. 
2. Define the number of plants planted per plot (NOPS) and the plot size (plot.size).
3. Run the code. 
4. See the result in the file checks.txt.

For example, if the data are in a csv file with name data.csv, NOPS is 3, and plot.size is 0.81, the following code will do the job:

```{r eval=F}
datos <- read.csv("data.csv", header=T)
NOPS <- 3
plot.size <- 0.81
source('checkconsis.R', echo=F, print.eval=T)
```

AMMI
-------------------------

Set of function to run AMMI (Golob, 1968, A Statistical Model which combines Features of Factor Analytic and Analysis of Variance Techniques, *Psychometrika*, Vol 33(1): 73-114).

### Function AMMIwithMeans.R
Function to compute AMMI from an interaction means matrix. For example, if the data is loaded in an object with name int.mean, the following code will do the job:
```{r eval=F}
source('AMMIwithMeans.R')
AMMIwithMeans(int.mean)
```
