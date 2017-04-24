#### C3W3 - Create New Variables

# Common variables to create
#       Missingness indicators
#       "Cutting up" quantitative varibles
#       Applying transforms

# Getting data form openbaltimore
# Create a folder data in case it does not exist
if(!file.exists("./data")){dir.create("./data")}

# Donwload the data form a url
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(url = fileUrl,
              destfile = "./data/restaurants.csv") #, method = curl) for mac
restData <- read.csv("./data/restaurants.csv")

# Creating sequences
s1 <- seq(1, 10, by=2); s1  # specify the step of the array
s2 <- seq(1, 10, length = 2); s2  # specify the length of the array
x <- c(1,3,8,25,100); seq(along = x)  # Create vector with indexes as x

# Subsetting variables
# Find the nearMe restaurants
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe) # add that info to the table

# Create binary varaibles (where the code is wrong)
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

# Creating categorical variables
# Break the data according to quantile values
restData$zipGroups = cut( restData$zipCode, 
                          breaks = quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)

# Easier cutting
install.packages("Hmisc")
library(Hmisc)
restData$zipGroups = cut2( restData$zipCode, g=4)
table(restData$zipGroups)

# Creating factor variables (giving the different levels of zipCode)
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)  # > factor

# Levels of factor variables
yesno  <- sample(c("yes", "no"), size = 10, replace = TRUE)
yesnofac  <- factor(yesno, levels = c("yes", "no"))
relevel(yesnofac, ref = "yes")  # Take the reference class as yes
as.numeric(yesnofac)  # Change that variable into numeric class

# Cutting produces factor variables
library(Hmisc)
restData$zipGroups = cut2( restData$zipCode, g=4)
table(restData$zipGroups) # now is a factor variable

# Using mutate function
library(Hmisc); library(plyr)
# create a new data frame to restData and add a new variable
restData2 = mutate(restData, zipGroups = cut2(zipCode, g=4))
table(restData2$zipGroups) 

# Transformations: abs, sqrt, ceiling, floor, round, signif, cos, log, exp

