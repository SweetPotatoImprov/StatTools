CheckConsis
===========

Set of rules to check for consistency of sweetpotato field experiments data in R.
Data labels must be defined as specified in the PROCEDURES FOR THE EVALUATION AND ANALYSIS
OF SWEETPOTATO TRIALS document.

1. Load the data in an object with name mydata. 
2. Define the number of plants planted per plot (NOPS) and the plot size (plot.size).
3. Run the code. 
4. See the result in the file checks.txt.

For example, if the data are in a csv file with name mydata.csv, NOPS is 3, and plot.size is 0.81, the following code will do the job:

```{r eval=F}
mydata <- read.csv("mydata.csv", header=T)
NOPS <- 3
plot.size <- 0.81
source('checkconsis.R', echo=F, print.eval=T)
```
