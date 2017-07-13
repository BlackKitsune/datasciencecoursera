### C4W2 - ggplot2 Plotting system

## What is ggplot2?
# Grammar of graphics representing and abstraction of graphics ideas/objects
# A statistical graphic is a mpping from data to atributes (color, shape, size)
# of geometric objects (point, line, bars), that can also contain statistical
# transformation of the data and is dran on a specific coordinate system

install.packages("ggplot2")

## The basic qplot(x, y, data-frame) "quick plot"
# like plot() function in base systerm
# data should be on a data frame, similar to lattice, or in parent environment
# Plots are made of aesthetics (size, shape, color) and geoms (point, lines)
# Factors are subsets of data (labeled)
# qplot() hides what goes on underneath
# ggplot() is the core function and very flexible better than qplot()
# Dificult to customize
# Factor label information important for annotation

## Example Dataset
library(ggplot2)
str(mpg)
qplot(disp, hwy, data = mpg)

## Change the color of subplots (color aesthetic) with autolegend placement
qplot(displ, hwy, data = mpg, color = drv)

## Adding a geom (statistics) to smooth the data
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))

## Histogram specifiying the highway variable, color diff by driver
qplot(hwy, data = mpg, fill = drv)

## Facets (like panels in lattice) row ~ col (if not .)
qplot(displ, hwy, data = mpg, facets = .~drv)
qplot(hwy, data = mpg, facets = drv~., binwidth = 2)

## MAACS Cohort
# Mouse allergen and asthma cohort study
# Persistent asthma and relation with environment 
# $eno = Exhaled nitric oxide, $pm25 = fine particulate matter, $mopos = skin test

str(maacs)
qplot(log(eno), data = maacs)
qplot(log(eno), data = maacs, fill = mopos) ## separate color the skin test

## Density smooth
qplot(log(eno), data = maacs, geom = "density")
qplot(log(eno), data = maacs, gein = "density", color = mopos)

## Scatterplots: eno vs pm25
qplot(log(pm25), log(eno), data = maacs)
qplot(log(pm25), log(eno), data = maacs, shape = mopos) ## separate by shape
qplot(log(pm25), log(eno), data = maacs, color = mopos) ## separate by color

## Smoothed data
qplot(log(pm25), log(eno), data = maacs, color = mopos) + geom_smooth(method = "lm")
qplot(log(pm25), log(eno), data = maacs, facets = .~mopos) + geom_smooth(method = "lm")

### 
