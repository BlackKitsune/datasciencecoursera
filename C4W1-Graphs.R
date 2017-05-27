### C4W1 - L1 - Principles of Analytic Graphics ####

## 1. Show comparisons (evidence is always relative to other evidence)
#       - Evidence for a hypothesis is always relative to another hypothesis
#       - Always as "Compared to What?" (Control setting: if something works,
#         compare it with "doing nothing" or other methods)

## 2. Show causality, mechanism, explanation, systematic structure
#       - What is the casual framework for thinking about a question?
#       - Confirm that the explanation is valid with other graphic

## 3. Show Multivariate data (compare to other variations)
#       - Multivariate = more than 2 variables
#       - Same plot but depending on other variables (seasons, time of day)

## 4. Integration of different modes of evidence (tables, text, graphs...)
#       - Completly integrate words, numbers, images, diagrams
#       - Data graphics should make use of many modes of data presentations
#       - Don't let the tool make the analysis

## 5. Describe and document the evidence with labels, scales, sources...
#       - A data graphic should tell a complete story that is credible

## 6. Content is king
#       - Analytical presentations ultimatelz stand of fall depending on
#         the quality, relevance, and integrity of their content

#### C4W1 - Exploratory Graphs ####

## Why do we use graphs in data analysis?
#       - Understand properties and find patterns in data
#       - Suggest modeling strategies or debug analyses
#       - To communicate results

## Exploratory graphs are the 4 first points (except communicate)
#       - The are made quickly (and in large number)
#       - Goal for personal understanding what is happening
#       - Axes/legends are cleaned up later
#       - Color/size are used for information

## Example: Air Pollution in the US (EPA Environmental Prtection Agency)
#       - For fine particle pollution (PM2.5), the anual mean, averaged 
#         over 3 years" cannot exceed 12 micro gr/m3
#       - Data on daily PM2.5 are available on EPA
#       - Question: Are there US counties > national standard pollution?

# Annual average PM2.5 over period 2008 through 2010 (>12 micro gr/m3)

pollution <- read.csv("data/avgpm25.csv",
                      colClasses = c("numeric", "character", "factor",
                                     "numeric", "numeric"))
head(pollution)

# columns: pm25 fips region longitude latitude

summary(pollution$pm25)  # To see the statistics

boxplot(pollution$pm25, col = "blue")  # Median over the limit?
abline(h =12)  # Horizontal line of the standard over 12

hist(pollution$pm25, col = "green")    # Distribution shape
rug(pollution$pm25)  # All the points under the distribution
abline(v = 12, lwd = 2)  # Vertical line at 12, line width 2
abline(v = median(pollution$pm25), col = "magenta", lwd = 4) # Median line

hist(pollution$pm25, col = "green", breaks = 100)    # Resolution of bars
rug(pollution$pm25)

barplot(table(pollution$region), col = "wheat",
        main = "Number of Counties in Each region") # Categorical data

## Simple summaries of data
# = 2D: Multiple/overlayed 1D plots (Lattice/ggplot2)
#       Scatterplots (smooth)
# > 2D: Overlayed/multiple 2D plots (coplots)
#       Use color, size, shape to add dimensions
#       Spinning plots
#       Actual 3D plots (not that useful)

# Multiple Boxplots (east/west pollution values)
boxplot(pm25 ~ region, data = pollution, col = "red")

# Multiple Histograms (east/west pollution distribution)
par(mfrow = c(2,1), mar = c(4,4,2,1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")

# Scatterplot (Nort/south trend (latitude) pollution distribution)
with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)

# Scatterplot - Using color (different color for the regions)
with(pollution, plot(latitude, pm25, col = region))
abline(h = 12, lwd = 2, lty = 2)

# Multiple Scatterplots (The same but with 2 plots Eart/west)
par(mfrow = c(1,2), mar = c(5,4,2,1))
with(subset(pollution, region == "east")$pm25, 
     plot(latitude, pm25, main = "East"))
with(subset(pollution, region == "west")$pm25, 
     plot(latitude, pm25, main = "West"))

## Summary:
#       - Exploratory plots are quick and dirty
#       - Let you summarize the data (graphically)
#       - Explore basic questions and hypotheses 
#       - Suggest modeling strategies for the next step
