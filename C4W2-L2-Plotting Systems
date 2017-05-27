#### C3W1 - L2 - Plotting Systems in R ####

## The Base Plotting systems (Artist's Palette model)
#       - Start with blank canvas and build up from there
#       - Use annotation functions to add/modify(text, lines, points, axis)
#       - But can't go back once plot has started (need plan in advance)
#       - Difficult to translate to others
#       - Plot is jus a series of R commands

# Base Plot
library(datasets)
data(cars)
with(cars, plot(speed, dist))

## The Lattic System
#       - Plots are created with a single function call(xyplot, bwplot)
#       - Most useful for conditioning types of plots (changes x across z)
#       - Margins/spacing set automatically
#       - Good for putting many plots on a screen
#       - Sometimes difficult to specify entire plot in single function
#       - Add to a plot once is created

# Lattice Plot
install.packages("lattice")
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))


## ggplot2 system
#       - Splits the difference between base and lattice
#       - Deals with spacings, text, title and allows add to plot
#       - More intuitive to use than lattice
#       - Default makes many choices but customizable

install.packages("ggplot2")
library(ggplot2)
data(mpg)
qplot(dipl, hwy, data = mpg)

## Summary
#       - Base: artist palette model
#       - Lattice: Entire plot specified by one function, conditioning
#       - ggplot2: Mixes elements of Base and Lattice
        
## 1. Base Plotting

# Base Pacakges: 
#       - graphics: base graphic systems plot,hist,boxplot...
#       - grDevices: graphic devices X11, PDF, PostScript, PNG,...
# Lattice Packages:
#       - lattice: Trellis graphics independent of base system (xyplot,
#         bwplot, levelplot...)
#       - grid: lattice package builds on top of grid

## Making a plot with base graphics
# Phases: Initializing a new plot + Annotating (add to) an existing plot
# Calling plot(x,y) or hist(x,y) launch graphic device
# If not specified the default method is called in plot
# The base graphics szstem has many parameters (?par)

# HISTOGRAM
library(datasets)
hist(airquality$Ozone)  ## Draw a new plot

# SCATTERPLOT
library(datasets)
with(airquality, plot(Wind, Ozone))

# BOXPLOT
library(datasets)
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month",
        ylab = "Ozone (ppb)")

## Base graphics PARAMETERS
#       - pch (plotting symbol)
#       - lty (line type)
#       - lwd (line width)
#       - col (color as number, string, hex code --> colors())
#       - x/ylab (x/y axis label)

## par() function PARAMETERS (global graphic parameters)
#       - las (orientation of axis labels)
#       - bg (background color)
#       - mar (margin size)
#       - oma (outer margin size)
#       - mfrow (number plots per row, column (filled row wise))
#       - mfcol (number plots per row, column (filled col wise))

par("lty")  ## Show the default values
par("col")
par("pch")
par("bg")
par("mar")
par("mfrow")

## Base Plotting functions
# plot: scatterplot
# lines: add lines to a plot
# points: add points to a plot
# text: add text label using x, y coordinates
# mtext: add arbitrary text to margins 
# axis: add axis ticks/labels


libray(datasets)
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in NY city")  ## Add a title

# OR

with(airquality, plot(Wind, Ozone), 
     main = "Ozone and Wind in NY city")

# Add subset of point of month may in different color
with(subset(airquality, Month = 5), points(Wind, Ozone, col ="blue"))

# Set the empthy plot with type = "n" and then fill it with subsets
with(airquality, plot(Wind, Ozone, 
     main = "Ozone and Wind in NY city", type = "n"))
with(subset(airquality, Month = 5), points(Wind, Ozone, col ="blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col ="red"))
# Add legend to the plot
legend("topright", pch = 1, col = c("blue", "red"),
       legend = C("May", "Other Months"))

# Add the regression line to a scatter plot
with(airquality, plot(Wind, Ozone, 
     main = "Ozone and Wind in NY city", pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

## Multiple Base plots
par(mfrow = c(1,2)) ## 1 row and 2 columns
with(airquality, {
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})

par(mfrow = c(1,3), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(airquality, {
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
        plot(Temp, Ozone, main = "Ozone and Temperature")
        mtext("Ozone and Wather in NY city", outer = TRUE)
})


## Example of plotting

# Create some data
x <- rnorm(100)
y <- rnorm(100)
z <- rnorm(100)

# Simple representation
hist(x)
plot(x,y)
plot(x,z)

# Margins: (1 botton, 2 left, 3 top and 4 right), change the margins
par("mar")
par(mar = c(4,4,2,2))

# Different symbols (Example("points")) with tittle
plot(x,y, pch = 20)
tittle("Scatterplot")

# Text (position, text)
text(-2,-2, "label")

# legend: topleft/right and bottonleft/right
legend("topleft", legend = "Data", pch = 20)

# Add linear fitting of the data
fit <- lm(y ~x)
abline(fit, lwd = 3, col = "blue")

# Complete:
plot(x, y, xlab = "Height", ylab = "Weight", 
     main = "Scatterplot", pch = 20)
legend("topleft", legend = "Data", pch = 20)
fit <- lm(y ~x)
abline(fit, lwd = 3, col = "blue")

# Multiple plots
z <- rpois(100,2)
par(mfrow = c(2,1))
plot(x,y, pch = 20)
plot(x,z, pch = 19)
par(mar = c(2,2,1,1))
plot(x,y, pch = 20)
plot(x,z, pch = 19)

par(mfrow = c(2,2)) # row wise fill
plot(x,y, pch = 20)
plot(x,z, pch = 20)
plot(z,y, pch = 20)
plot(y,z, pch = 20)

par(mfcol = c(2,2)) # col wise fill
plot(x,y, pch = 20)
plot(x,z, pch = 20)
plot(z,y, pch = 20)
plot(y,z, pch = 20)


# Differentiate values by color
par(mfrow = c(1,1))
x <- rnorm(100)
y <- x + rnorm(100)

g <- gl(2, 50, labels = c("Male", "Female"))
str(g)
plot(x,y) # No distinction male/female in the plot
plot(x,y, type = "n") # Plot with no data
poitns(x[g == "Male"], y[g == "Female"], col = "green") # Plot male data
poitns(x[g == "Female"], y[g == "Male"], col = "blue") # Plot female data
