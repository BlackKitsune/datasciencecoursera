### C3W4 - Editing text variables

## Fixing character vectors - tolower() and toupper()
# Download the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv") #, method = "curl")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)

## Make all of the names of the variables lowercase
tolower(names(cameraData))

## Fixing characters vectors - strsplit()
# Automatically splits variable names, paramenters (x, split)
# Separate variables with names separated by . or other
splitNames = strsplit(names(cameraData), "\\.")
splitNames[[5]] # "intersection" nothing happen because ther is no .
splitNames[[6]] # "Location" "1"

## Quick aside - list (subset)
mylist <- list(letters = c("A","b","c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
mylist$letters  # A, b, c
mylist$numbers  # 1 2 3
mylist[1]
mylist[[1]]

## Fixing character vectors - sapply()
# Applies a function to each element in a vector or list
# Important paramenters X, FUN (variable and function to apply)
# Example: Remove all the periods and take only the first part of the name
splitNames[[6]][1]  
firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)

## Peer review data
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile = "./data/reviews.csv") #, method = "curl")
download.file(fileUrl2, destfile = "./data/solutions.csv") #, method = "curl")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)

## Fixing characters vectors - sub()
# Important paramenters (pattern, replacement, x)
names(reviews)  # Some of them have underscores
sub("_", "", names(reviews),)

## Replace multiple characters in a variable
testName <- "this_is_a_test"
sub("_", "", testName)
gsub("_", "", testName)

## Finding values - grep(), grepl()
# Find all the elements that content "Alameda" in "intersection" var
grep("Alameda", cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),]

# value = TRUE returns the values where "Alameda" appears
grep("Alameda", cameraData$intersection, value = TRUE)

# Elements that doesn't appear will return > integer(0)
grep("JeffStreet", cameraData$intersection)
length(grep("JeffStreet", cameraData$intersection))

## More useful string functions
install.packages("stringr")
library(stringr)

# Number of characters of a particular string
nchar("Jeffrey Leek")

# Take part of the string
substr("Jeffrey Leek",1,7)

# Paste two strings together, sep = gives the separation
paste("Jeffrey", "Leek")
paste0("Jeffrey", "Leek")  # with no separation

# Eliminate any excess space
str_trim("Jeff    ")

## Important points about text in data sets
# Names of the variables should be:
#   - Lower case when possible
#   - Descriptive(Ex: Diagnosis versus Dx)
#   - Not duplicated
#   - Not have underscores or dots or white spaces
# Variables with character values
#   - Should usually be made into factor variables
#   - Should be descriptive (use TRUE/FALSE, male/female instead of 0/1)
