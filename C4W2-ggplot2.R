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

### Basic components:
#   - Data frame
#   - Aesthetic mapping: How data are mapped to color, size...
#   - geoms: geometric objects like points, lines or shapes
#   - facets: for conditional plots
#   - stats: statistical transformations (binning, quantiles, smoothing)
#   - scales: How variables are defined and separated (variable sex, male red, female blue)
#   - coordinate system

## Building plots with ggplot2
# It is the artist palette from ggplot2
# Plots are built up in layers: Plot data + Overlay summary + Metadata + Annotation

## Exaple MAACS: BMI (normal vs overweight), pm25 (indoor pullution), eno (NO interaction)

# With qplot
qplot(logpm25, NoturnalSympt, data = maacs,
      facets = . ~ bmicat,  ## two panels normal/overweight
      geom = c("point", "smooth"),    ## add data (point) and smooth regression
      method = "lm")

# Build up in layers with ggplot
head(maacs[, 1:3])    ## the frist lines of the maacs data frame
g <- ggplot(maacs, aes(logpm25, NoturnalSympt))   ## Initial call to ggplot
                                                  ## Aesthetics is NocturnalSympt
summary(g)    ## Summary of the ggplot object

# If we call print(g) after the initial call, error! no layers (it does not know how to plot)
g <- ggplot(maacs, aes(logpm25, NoturnalSympt))
print(g) 
# Error: No layers in plot

p <- g + geom_point()   ## Explicity save and print ggplot object
print(p)                ## Print into the screen OR 

g + geom_point()        ## Auto print plot object without saving

# Example of the call
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
g + geom_point()

## Adding More layers: Smooth
# Add a sense of the overal trend in the data

g + geom_point() + geom_smooth() ## Adds the smooth to the data
g + geom_point() + geom_smooth(method = "lm")  ## Linear regression

## Add facets, Faceting(factor) variable with the labels from facet variable
g + geom_point() + geom_smooth(method = "lm") + facet_grid(. ~ bmicat)  

## Annotation
#   - Labels: xlab(), ylab(), labs(), ggtitle()
#   - Each geom functions has options
#   - theme() to change things globally (theme(legend.position = "none")
#   - Standard appearance themes include
#       * theme_gray() by default with gray background
#       * theme_bw() more stark/plain

## Modifiying Aesthetics

# Change the color of the plot data (blue solid to transparent with constant values)
g + geom_point(color = "steelblue", size = 4, alpha = 1/2)

# or differenciate by color in the bmicat variable (aes() = aesthetics) with data variable
g + geom_point(aes(color = bmicat), size = 4, alpha = 1/2)

## Modifiying the labels
g + geom_point(aes(color = bmicat), size = 4, alpha = 1/2) +
  + labs(title = "MAACS cohort") +
  + labs(x = expression("log ") * PM([2.5]), y = "Nocturnal Symptons")

# Customizing the smooth (size, type line, method, turned of confidence lines)
g + geom_point(aes(color = bmicat), size = 4, alpha = 1/2) +
  + geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)

# Changing the Theme (bw black/white theme, and change the font to "Times")
g + geom_point(aes(color = bmicat), size = 4, alpha = 1/2) +
  + theme_bw(base_family = "Times")

## Notes about Axis limits



testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat`0, 2



















