### C4W2 - EXPLORATORY DATA ANALYSIS

## LATTICE POTTING SYSTEM

# Lattice contains code for producing trellis graphics
# Independent of base graphics
# Builds on top of a grid
# Does not have two-phase plot and annotation
# All done with one single function

# Lattice functions:
#   - xyplot: scatterplots
#   - bwplot: boxplot
#   - histogram
#   - stripplot: boxplot with points
#   - dotplot: plot dots on violin strings
#   - splom: scatterplot matrix (= pairs() in base plot)
#   - levelplot, countourplot: for plotting image data

# Lattice Functions: 
#   - With formula notation xyplot(y ~x | f * g, data)
#   - (x, y) variable
#   - (f, g) condicioning variables (optional)
#   - data-frame/list with variables in formula should look
#   - if not data/list used then the parent frame is used

library(lattice)
library(datasets)

## Simple scatterplot
xyplot(Ozone ~ Wind, data = airquality)

## Convert "Month" to a factor variable
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))

# Lattice Behavior:
#   - base graphics plot data to a graphics device (screen, pdf,...)
#   - Lattice retunr and object of class trellis
#   - Plot directly to graphic device
#   - Object can be stored but it is better to save code + data
#   - On the command line trellis objects are auto printed

## Example without auto printing
p <- xyplot(Ozone ~ Wind, data = airquality) ## Nothing happens
print(p)   ## Plot appears

## Example with auto printing
xyplot(Ozone ~ Wind, data = airquality) ## Auto-printing

# Lattice Panel Functions:
#   - lattice have panel functions to control in each plot panel
#   - They are customizable
#   - Panel func. receive x/y coordinates of the data points in their panel

## Plot with 2 panel
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2,1)) 

## Custom panel function with some horizontal lines
xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)  ## First cal default panel function
  panel.abline(h = median(y), lty = 2). ## Add a horizontal line at the median
  })
  
## Regression line
xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)  ## First cal default panel function
  panel.lmline(x, y, col = 2). ## Overlay a simple linear regression line
  })

# Many panel lattice plot (MAACS): Studz from asthma
# You can look a lot of data without to many effort

## Summary
# Constructed with one single function
# A lot of things are handle by default (spacing, labels, ...)
# Ideal for conditional plots to examine same kind of plot under diff conditions
# Panel function can be specified
