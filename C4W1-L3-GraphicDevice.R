### C4W1 - L3 - Graphic Devices

## What is a Graphics Device? Something were you can make a plot appear
#   - Window on the computer, pdf file, png or jpg files,...
#   - A plot in R has to be sent to a spcedific graphic device
#   - Most common the screen device (quartz() on Mac, windows() on win, x11() linux)
#   - ?Devices show you the ones created by CRAN

## How does a plot get created? 1
#   - Call plotting function (plot, xplot, qplot)
#   - Plot appears on the sreen device
#   - Annotate plot if necessary

library(datasets)
with(faithful, plot(eruptions, waiting)   ## Make plot appear on screen device
tittle(main = "Old Faithful Geyser data")   ## Annotate with the title

## How does a plot get created? 2
#   - Explicitly launch a graphics device
#   - Call a plotting function to make a plot (if using file device, no plot appear)
#   - Annotate plot if necessary
#   - Explicitly close graphics device with dev.off() (very important)

pdf(file = "myplot.pdf")  ## Open pdf device, create myplot in my working directory
## Create plot and send to a file (no plot appears on screen)
with(faithful, plot(eruptions, waiting)
tittle(main = "Old Faithful Geyser data")   ## Annotate with the title
dev.off()   ## Close the pdf file device
## Now you can se the file myplot.pdf on your computer.

## Graphics File Devices: Vector and bitmap devices
#   1. Vector: pdf (line, plot), svg (XML,web animations), win.metafile, and
#              psotscript (resizing, portable, encapsulated)
#   2. Bitmap: png (pixels, efficient), jpeg (compression, lots of points),
#              tiff (compression), bmp (native windows)

## Multiple Open Graphics Devices
# Possible to open multiples at the same time, but only will be ploted at the time
# Current active graphic device with dev.cur()
# Every open graphics device is assigned and integer >=2
# Change graphics device with dev.set(<integer>) with the num. associated to that graphic dev.

## Copy plots from one device to another
# dev.copy: copy a plot from one device to another
# dev.copy2pdf: specifically copy a plot to a PDF file

library(datasets)
with(faithful, plot(eruptions, waiting)
tittle(main = "Old Faithful Geyser data")   ## Annotate with the title
dev.copy(png, file = "geyserplot.png") ## copy myplot to png file
dev.off()

## Summary
#   - Plot must be created on a graphics device
#   - Almost always you have to send it to file device

