#### C3W1 - Swirl practice

# Clean the list of variables in your workspace
rm(list = ls())

# Begin 
install_from_swirl("Getting and Cleaning Data")
library(swirl)
swirl()

# 4: Dates and Times with lubridate (For UT US only)

# In this lesson, we'll explore the lubridate R package, by Garrett
# Grolemund and Hadley Wickham. According to the package authors,
# "lubridate has a consistent, memorable syntax, that makes working with
# dates fun instead of frustrating." If you've ever worked with dates in
# R, that statement probably has your attention.

Sys.getlocale("LC_TIME")
library(lubridate)
help(package = lubridate)

# Store the today date in a variable called this_day (year,month,day)
this_day <- today()
this_day
year(this_day)
month(this_day)
day(this_day)

# Get the day of the week
wday(this_day)
wday(this_day, label = TRUE)

# date and time combinations
this_moment <- now()
this_moment
hour(this_moment)
minute(this_moment)
second(this_moment)

# y is years, m is months, d is days, h for hours, m for minutes and s for secs
ymd("1989-05-17")
dmy("1989-05-17")
hms("1989-05-17")
ymd_hms("1989-05-17")

my_date <- ymd("1989-05-17")
my_date
class(my_date)

ymd("1989 May 17")
mdy("March 12, 1975")
dmy(25081985)
ymd("1920/1/2")
ymd("1920-1-2")

# > dt1
# [1] "2014-08-23 17:23:02"
ymd_hms(dt1)

hms("03:22:14")

# > dt2
# [1] "2014-05-14" "2014-09-22" "2014-07-11"
ymd(dt2)

# update() function
update(this_moment, hours = 8, minutes = 34, seconds = 55)
this_moment
this_moment <- update(this_moment, hours = 10, minutes = 16, seconds = 0)
this_moment

# Now, pretend you are in New York City and you are planning to visit a
# friend in Hong Kong. You seem to have misplaced your itinerary, but you
# know that your flight departs New York at 17:34 (5:34pm) the day after
# tomorrow. You also know that your flight is scheduled to arrive in Hong
# Kong exactly 15 hours and 50 minutes after departure.
nyc <- now("America/New_York")
nyc

depart <- nyc + days(2)
depart
depart <- update(depart, hours = 17, minutes = 34)
depart

arrive <- depart + hours(15) + minutes(50)
# Convert arrive time to asia time zone
?with_tz
arrive <- with_tz(arrive, tzone = "Asia/Hong_Kong")
arrive

# Last time you visited Singapore
last_time <- mdy("June 17, 2008", tz = "Singapore")
last_time

?interval
how_long <- interval(last_time,arrive)
as.period(how_long)

