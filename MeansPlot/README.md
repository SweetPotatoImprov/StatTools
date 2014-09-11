MeansPlot.R
-----------

### Description

An alternative to the controversial and ugly dynamite plots.

### Usage

```{r eval=F}
MeansPlot(trait, groups, data, conf = 0.95, file.name = "MeansPlot",
          main.title = "", x.title = "groups", y.title = "",
          col = "black", bg = "darkorange", col.lines = "black",
          width = 480, height = 480)
```

### Arguments

```
trait      : Trait to analyze.
groups     : Grouping factor.
data       : Data frame containing the data.
conf       : Probability for the confidence limits.
file.name  : File name for plot.
main.title : Main title.
x.title    : Title for x axis.
y.title    : Title for y axis.
col        : Line color for circles.
bg         : Background color for circles.
col.lines  : Line color for confidenced interval lines.
width      : Width size.
height     : Height size.
```

### Value
It returns a plot with the means and confidence limits for each group.
The plot is saved in the working directory as a png file.

### Example


```{r eval=F}
# Run the following code to load the function:
source("MeansPlot.R")

# Simulate some data
mydata <- data.frame(y = rnorm(100, sample(80:120, 10), sample(10:20, 10)), g = rep(1:10, 10))

# Draw the plot
MeansPlot("y", "g", mydata)
```
