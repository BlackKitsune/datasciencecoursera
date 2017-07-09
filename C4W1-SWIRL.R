### C4W1 - SWIRL Practice

## PRINCIPLES OF EXPLORATORY GRAPHICS

#   1. Comparisons: Show evicence relative to other evidence
#   2. Causality, mechanisms, explanations and systematic structure
#   3. Multivariante data
#   4. Integrate different modes of evidence (tables, text, plots)
#   5. Description/documentation of the evidence (labels, scales, sources...)
#   6. Content is the king (quality, relevance and integrity)

## EXPLORATORY GRAPHS: Tool for data scientists 

# To understand data properties 
# To find patterns in data
# To suggest modeling strategies
# Graphics give us some visual form of data
# Graphs give us a compact way to present data and find or display any pattern 
# A picture is worth a 1000 words

# Exploratory graphs serve mostly the same functions as graphs. 
# They help us find patterns in data and understand its properties. 
# They suggest modeling strategies and help to debug analyses. 
# We DON'T use exploratory graphs to communicate results.
# The "quick and dirty" tool used to point the data scientist in a fruitful direction. 
 
# Data from the U.S. Environmental Protection Agency (EPA) which sets national ambient air quality standard
# for outdoor air pollutio: fine particle pollution (PM2.5), "annual mean, averaged over 3 years" < 12 ug/m3
# Use the R function head to see the first few entries of   pollution.

head(pollution)

# At least one county exceeding the EPA's standard of 12 micrograms per cubic meter.
# The  pollution count is in the first column labeled pm25. 
# The state (first 2 digits) and county (last 3 digits) with that count 
# The associated region (east or west), and the longitude and latitude of the area. 
# Now run the R command dim with pollution as an argument to see how long the table is.

dim(pollution)

# There are 576 entries in pollution
# "Are there any counties in the U.S. that exceed that national standard"

# The first technique uses the R command summary, a 5-number summary which returns 6 numbers. 
# Run it now with the pm25 column of pollution as its  argument. 
# Recall that the construct for this is pollution$pm25.

summary(pollution$pm25)

# This shows us  basic info about the pm25 data
#     - Minimum (0 percentile) and Maximum (100 percentile) values
#     - Quartiles of the data: measures at which 25%, 50%, and 75% 
#     - Mean or average measure of particulate pollution across the 576 counties.    

# Half the measured counties have a pollution level less than or equal to what number of micrograms per cubic meter? 
# 10.050

# ppm <- pollution$pm25 
# Try it now as the argument of the R command quantile. 
# See how the results look a lot like the results of the output of the summary command.

quantile(ppm)

# Quantile gives the quartiles, What is the one value  missing from this quantile output that summary gave you?
# the mean

# BOXPLOT: Run the R command boxplot with ppm as an input and the color parameter col equal to "blue".

boxplot(ppm,col="blue")

# The boxplot shows us the same quartile data that summary and quantile did. 
# The lower and upper edges of the blue box respectively show the values of the 25% and 75% quantiles.  

# What do you think the horizontal line inside the box represents?
# the median

# The "whiskers" of the box relate to the range parameter of boxplo (default R value 1.5). 
# The height of the box is the interquartile range, the difference between the 75th and 25th quantiles = 2.8. 
# The whiskers length = range*2.8 = 1.5*2.8. 
# This shows how many data points are outliers = beyond this range of values. 

# This package provides the ability to overlay feature = add to (annotate) an existing plot.

abline(h = 12)

# Adds one or more straight lines through the current plot. 
# We see from the plot that the bulk of the measured counties comply with the standard since they 
# fall under the line marking that standard.

# HIST: Distribution of the pollution counts, or how many counties fall into each bucket of measurements. 

hist(ppm, col = "green")

# What are the most frequent pollution counts?
# between 9 and 12

# Now run the R command rug with the argument ppm.

rug(ppm)

# 1D grayscale plot, info about how many data points are in each bucket and where they lie within the bucket. 
# It shows (through tick density) concentration of counties in each bucket.

# high/low vectors = pollution data of high (>15)/low (<5). See if the results of rug are correct

low
high

hist(ppm, col = "green", breaks = 100)

# What do you think the breaks argument specifies in this case?
# the number of buckets to split the data into
# So this histogram with more buckets is not nearly as smooth as the preceding one. 
# In fact, it's a little too noisy to see the distribution clearly. 
# When you're plotting histograms you might have to experiment with the argument breaks 

# For fun now, rerun the R command rug with the argument ppm.

rug(ppm)

# It automatically adjusted its pocket size to that of the last plot plotted.

hist(ppm, col = "green")
abline(v = 12, lwd=2)
abline(v = median(ppm), col = "magenta", lwd = 4)

# This shows that although the median (50%) is below the standard, 
# there are a fair number of counties in the U.S that have pollution levels higher than the standard.

# Now recall that our pollution data had 5 columns of information.  

names(pollution)

# Let's look at the region column to see what's there. 
# Run the R command table on this column. Use the construct pollution$region. Store the result in the variable reg. 

reg <- table(pollution$region)
reg

# BARPLOT: reg as its first argument, col equal to "wheat", and main equal to "Number of Counties in Each Region".

barplot(reg, col = "wheat", main = "Number of Counties in Each Region")

# What do you think the argument main specifies?
# the title of the graph

# Two dimensional graphs include scatterplots, multiple graphs which we'll see more examples of, 
# and overlayed one-dimensional plots which the R packages such as lattice and ggplot2 provide.

# Some graphs have more than two-dimensions: 
# These include overlayed or multiple two-dimensional plots  and spinning plots. 
# Some three-dimensional plots are tricky to understand so have limited applications. 
# We'll show two graphs together.

# First we'll show how R, in one line and using base plotting, can display multiple boxplots. 
# We simply specify that we want to see the pollution data as a function of region. 
# We know that our pollution data belongs to one of two regions (east and west).

# We use the R formula y ~ x to show that y (in this case pm25) depends on x (region). 
# Since both come from the same data frame (pollution) we can specify a data argument set equal to pollution. 
# By doing this, we don't have to type pollution$pm25 (or ppm) and pollution$region. 
# We can just specify the formula pm25~region. 
# Call boxplot now with this formula as its argument, data equal to pollution, and col equal to "red". 

boxplot(pm25 ~ region, data = pollution, col = "red")

# We can plot multiple histograms in one plot, 
# Set up the plot window with the R par which specifies how we want to lay out the plots say one above the other. 
# And specify margins, 4-long vector which indicates the number of lines for the bottom, left, top and right. 
# Type the R command par(mfrow=c(2,1),mar=c(4,4,2,1)) now. Don't expect to see any new result.

par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))

# So we set up the plot window for two rows and one column with the mfrow argument. 
# The mar argument set up the margins. 

# Call subset now with pollution as its first argument and a boolean expression testing region "east".

east <- subset(pollution,region=="east")
head(east)
hist(east$pm25, col = "green")

# The command par told R we were going to have one column with 2 rows, placing the histogram in the top position.

# Plot the histogram of the counties from the west using just one R command. 
# Let the appropriate subset command (with the pm25 portion specified) be the first argument and col 
# (equal to "green") the second.

hist(subset(pollution,region=="west")$pm25, col = "green")

# See how R does all the labeling for you? Notice that the titles are different since we used different 
# commands for the two plots. Let's look at some scatter plots now. 

# PLOT: Scatter plots are two-dimensional plots which show the relationship between two variables, usually x and y. 
# Let's look at a scatterplot showing the relationship between latitude and the pm25 data. 
# Call plot with the arguments latitude and pm25 which are both from our data frame pollution. 

with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)

# lty=2 made the line dashed.

# call  plot directly with 3 arguments: pollution$latitude, ppm and col = pollution$region. 

plot(pollution$latitude, ppm, col = pollution$region)

# We've got two colors on the map to distinguish between counties in the east and those in the west. 
# Can we figure out which color is east and which west? 
# See that the high (greater than 50) and low (less than 25) latitudes are both red. 
# Latitudes indicate distance from the equator, so which half of the U.S. (east or west) has counties at 
# the extreme north and south? west

abline(h = 12, lwd = 2, lty = 2)

# We see many counties are above the healthy standard set by the EPA, but it's hard to tell overall, 
# which region, east or west, is worse. 

# Let's plot two scatterplots distinguished by region.
# As we did with multiple histograms, we first have to set up the plot window with the R command par. 
# This time, let's plot the scatterplots side by side (one row and two columns). 
# We also need to use different margins. Type the R command par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))

par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
west <- subset(pollution,region=="west")
plot(west$latitude, west$pm25, main = "West")

# For the second scatterplot, on the right, we'll plot the latitudes and pm25 counts from the east.
# As before, use the up arrow key and change the 3 "West" strings to "East". 

plot(east$latitude, east$pm25, main = "East")

# See how R took care of all the details for you? Nice, right? 
# It looks like there are more dirty counties in the east but the extreme dirt (greater than 15) is in the west. 

# Let's summarize and review. 
# Which of the following characterizes exploratory plots? quick and dirty
# Plots let you summarize the data (usually graphically) and highlight any broad features. True
# Which of the following do plots do? ALL
#     a) Summarize the data (usually graphically) and highlight any broad features; 
#     b) Explore basic questions and hypotheses (and perhaps rule them out); 
#     c) Suggest modeling strategies for the "next step"


## GRAPHIC DEVICES IN R

# Short lesson introducing you to graphics devices in R.
# What IS a graphics device? Where you can make a plot appear
#   1. SCREEN DEVICE: such as a window on your computer (quarz() Mac, window() Windows and x11() Linux)
#      Simple aproach (plot, xyplot, qplot) + annotations to the plot
#   2. FILE DEVICE:
#      2.1 VECTOR: Line, solid colors, no many points
#          a) PDF (line, resize, portable, no many points)
#          b) SVG (XML, scalable, suports animation and interactiviy, web)
#          c) WIN META (Old, windows)
#          d) POSTSCRIPT (Old, resizes, encapsulated, no windows)
#      2.2 BTITMAP: Many points, natural scenes, web based plots
#          a) PNG (line, solid colors, lossless compresion, web, many points, not resize)
#          b) JPG (photography, lossy compresion, no resize, all computers/webs, no line)
#          c) TIFF (Old, lossless compresion, metaformat)
#          d) BMP (Native windows bitmat format)

# When you make a plot in R, it has to be "sent" to a specific graphics device. 
# Usually this is the screen (the default device), especially when you're doing exploratory work. 
# You'll send your plots to files when you're ready to publish them


# Run the R command ?Devices to see what graphics devices are available on your system.

?Devices
 
# SCREEN PLOT: 

with(faithful, plot(eruptions, waiting))
  
# See how R created a scatterplot on the screen for you? 
# This shows that relationship between eruptions of the geyser Old Faithful and waiting time. 

# Now use the R function title with the argument main set equal to the string "Old Faithful Geyser data". 
# This is an annotation to the plot.

title(main = "Old Faithful Geyser data")
  
# Now run the command dev.cur(). This will show you the current plotting device, the screen.

# FILE DEVICE:

pdf(file="myplot.pdf")

# You then call the plotting function (if you are using a file device, no plot will appear on the screen). 
# Run the with command again to plot the Old Faithful data. 
  
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")

# Finally, when plotting to a file device, you have to close the device with the command dev.off(). 
# This is very important! Don't do it yet, though. 
# After closing, you'll be able to view the pdf file on your computer.
 
# Although it is possible to open multiple graphics devices (screen, file, or both), 
# when viewing multiple plots at once, plotting can only occur on one graphics device at a time.

# The currently active graphics device can be found by calling dev.cur(). 
# Try it now to see what number is assigned to your pdf device.

dev.cur()

# Now use dev.off() to close the device.

dev.off()

# Now rerun dev.cur() to see what integer your plotting window is assigned.

dev.cur()

# The device is back to what it was when you started. As you might have guessed,  
# every open graphics device is assigned an integer greater than or equal to 2. 
# You can change the active graphics device with dev.set(<integer>) where <integer> is the 
# number associated with the graphics device you want to switch to.

# You can also copy a plot from one device to another. 
# This can save you some time but beware! Copying a plot is not an exact operation, 
# so the result may not be identical to the original.
# The function dev.copy copies a plot from one device to another, 
# and dev.copy2pdf specifically copies a plot to a PDF file.

with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")

# Now run dev.copy with the 2 arguments: png, and the second file = "geyserplot.png". 
# This will copy your screen plot to a png file in your working directory 
# which you can view AFTER you close the device.

dev.copy(png, file = "geyserplot.png")

# Don't forget to close the PNG device! Do it NOW!!! Then you'll be able to view the file.

dev.off()

## BASE PLOTTING SYSTEM

# BASE PLOT: Artist palette, you cannot go back on the plot to correct

with(cars, plot(speed, dist))
text(mean(cars$speed),max(cars$dist),"SWIRL rules!")

# LATTICE: Entire plot specified at once, not allowed add in separate calls

head(states)
table(states$region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))
xyplot(Life.Exp ~ Income | region, data = state, layout = c(2,2))

# GGPLOT2: Combines the best of base + lattice, uses graphic grammar

head(mpg)
dim(mpg)
table(mpg$model)
qplot(disp, hwy, data = mpg)


## BASE PLOTTING SYSTEM

# Graphics R engine: Graphics package (plot, hist,...) + Graph edevices (Implementing graphs)
# Base = Graphs + Adds
# Disadvantage = no going back once the plot has started
# Calling to plot, hist ... opens a graph device (default if not specify)
# Arguments(title, axis, margins, labels,...)
# Dataset airquality

head(airquality)
range(airquality$Ozone, na.rm = TRUE)  # Erase the na
hist(airquality$Ozone)    # Distribution of measurements
table(airquality$Month)   # Data covers 5 months
boxplot(Ozone ~ Month, data = airquality, 
        xlab = "Month", ylab = "Ozone (ppb)",
        col.axis = "blue", col.lab = "red",
        main = "Ozone and Wind in NYC")

# First argument Ozone as a function of months
# dataset for the measurements
# x and y labels
# color of the axis and the labels
# main title

# SCATTERPLOT:

with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in NYC")

# PAR: Plotting paramenters

length("par")    # Values set to paramenters
names("par")     # names for the set of paramentes
par("pin")       # Plot dimension en iches
par("fg")        # foreground color
par("bg")        # background color
par("pch")       # plot character (open circle by default)
par("lty/lwd")   # line type/width
par("xlab/ylab") # x/y axis labels
par("las")       # axis labels orientation
par("mar")       # margins size
par("oma")       # outer margin size
par("mfrow/mfcol")      # num plots per row/col filled by rows/cols first

dev.off()        # Reset to defaults
plot.new         # Reset to defaults

# ANNOTATING FUNCTIONS: text, points, title, lines, legend

# Set the plot but without data
plot(airquality$Wind, airquality$Ozone, type = "n")

# Add main title
title(main = "Wind and Ozone NYC")

# Add the data
may <- subset(airquality, Month == 5)
points(may$Wind, may$Ozone, col = "blue", pch = 17)
notmay <- subset(airquality, Month != 5)
points(notmay$Wind, notmay$Ozone, col = "red", pch = 8)

# Line with the median vaule
abline(v = median(airquality$Wind), lty = 2, lwd =2)


# MULTIPLOTS

# Create the frame with the rows and coloumns
par(mfrow = c(1,2))

# Add the plots
plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
plot(airquality$Solar.R, airquality$Ozone, main = "Ozone and Solar Radiation")

# Create the frame with the rows, cols and in/out margins
# margins(botton, left, up, right)
par(mfrow = c(1,3), mar = c(4,4,2,1), oma = c(0,0,2,0))

# Add the plots
plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
plot(airquality$Solar.R, airquality$Ozone, main = "Ozone and Solar Radiation")
plot(airquality$Temp, airquality$Ozone, main = "Ozone and Temperature")

# Main outer tittle
mtext("Ozone and Weather in NYC", outer = TRUE)

