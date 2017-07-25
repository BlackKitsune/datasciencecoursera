#### C4W3 - L3 - Working with Color

## Plotting and Color in R
# Colors 1,2,3,4,5 are white, red, green, cyan and magenta
# heat.colors() and top.colors() are palette of colors for surfaces

## grDevices package: colorRamp(), and colorRampPalette() (create palettes)
#     - This functions take paletes of color and interpolate between them
#     - colorRamp(): values (0,1) indicating the extremes
#     - colorRampPalette(): Takes an integer arguments and interpolate 
# colors() list the names of colors to use in any plotting function

# colorRamp()
pal <- colorRamp(c("red", "blue"))
pal(0)  ## RGB (maximum for red)
pal(1)  ## RGB (maximum for blue)
pal(0.5)    ## RGB (half red half blue interpolated)

# colorRamp(): sequence of colors between red and blue
pal(seq(0,1, len=10))

# colorRampPalette()
pal <- colorRampPalette(c("red", "yellow"))
pal(2)    ## Red and yellow
pal(10)   ## Range of 10 colors between red and yellow

## RColorBrewer Package (color palettes)
# CRAN package
# Types: 
#     - Sequential(numeric ordered data) --> from light to dark
#     - Diverging(deviations from the mean) --> (dark hot, light, dark cold)
#     - Qualitative(unorder data) --> Categorical data with a color theme
# Palette info can be used with colorRamp/Palette()

install.packages("RcolorBrewer")
library(RColorBrewer)
cols <- brewer.pal(3, "BuGn")   ## number of colors for the palette and name of it
cols
pal <- colorRampPalette(cols)
image(volcano, col = pal(20))

# smoothScatter() (for a lot of points that superpose one to the other)
x <- rnorm(10000)
y <- rnorm(10000)
smoothScatter(x, y)

## Other plotting notes
# rgb() takes arguments for red, green and blue and create a colro
# alpha = (0,1) can add transparency to rgb() 
# the colorspace package can be used for a different control over colors

# Scatterplot with no transparency (you dont see density)
plot(x, y, pch = 19)

# Scatterplot with transparency (dark is high density)
plot(x, y, col = rgb(0,0,0,0.2), pch=19)

## Summary
# Careful use of colors in plots/maps can make it easier to understand
# RColorBrewer package provide color palettes sequential, categorical and diverging
# colorRamp/Palette functions can be used to interpolate between colors
# Transparency is used to clarify plots with many points
