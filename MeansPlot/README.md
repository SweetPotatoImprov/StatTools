MeansPlot.R
-----------

### Description

An alternative to the controversial and ugly dynamite plots.

### Usage

```{r eval=F}
MeansPlot(trait, groups, data, conf = 0.95, sort.means = "none",
          main.title = "", x.title = "groups", y.title = "",
          col = "black", bg = "darkorange", col.lines = "black")
```

### Arguments

```
trait      : Trait to analyze.
groups     : Grouping factor.
data       : Data frame containing the data.
conf       : Probability for the confidence limits.
sort.means : Sort for means, "none" by default.
main.title : Main title.
x.title    : Title for x axis.
y.title    : Title for y axis.
col        : Line color for circles.
bg         : Background color for circles.
col.lines  : Line color for confidenced interval lines.
```

### Value

It returns a plot with the means and confidence limits for each group.

### Example

```{r eval=F}
# Download the MeansPlot.R function. This works well with RStudio.
urlfile <- "https://raw.githubusercontent.com/SweetPotatoImprov/StatTools/master/MeansPlot/MeansPlot.r"
source(urlfile)

# Simulate some data
mydata <- data.frame(y = rnorm(100, sample(80:120, 10), sample(10:20, 10)), g = rep(1:10, 10))

# Draw the plot
MeansPlot("y", "g", mydata)
```
