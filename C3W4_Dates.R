### C3W4 - Working with dates

# Character Date
d1 = date()
d1
class(d1)

# Date class
d2 = Sys.Date()
d2
class(d2)

# Formatting dates: %d day(0,31), %a abbrev weeday, %A weekday, 
# %m month(0,12), %b abbrev month, %B month, %y 2digit year, %Y 4digit year
format(d2, "%a %b %d")

# Creating dates
x = c("1jan1960", "2jan1960")
z = as.Date(x, "%d%b%Y")
z
a <- z[1] - z[2]
as.numeric(a)

# Converting to Julian (number of days since the origin)
weekdays(d2)
months(d2)
julian(d2)

# Lubridate package
install.packages("lubridate")
library(lubridate)

# Lubridate Dates
ymd("20140108")
mdy("08/04/2013")
dmy("03-04-2013")

# Lubridate Times
ymd_hms("2014-01-08 10:15:23")
ymd_hms("2014-01-08 10:15:23", tz = "Pacific/Auckland")
?Sys.timezone

# Functions with different syntax with lubridate
dates = c("1jan1960", "2jan1960")
x = dmy(dates)
wday(x[1])
wday(x[1], label = TRUE)

# Classes POSIXct and POSIXlt
