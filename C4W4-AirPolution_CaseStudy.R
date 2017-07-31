### C4W4 - Air Pollution In US - Case Study

## Are the air pollution level better or worse now?
## Data from 1999 and 2012, what levels are lower/bigger?

## Opening the file:
# Heather first 2 lines
# Columns: RD -> I, Action code, State Code, Conty Code ID, Parameter, POC, Sample duration,
#          Unit, Method, Date, Start Time, Sample Value, Null Data Code, Sampling freequency,
#          Monitor protocol (MP) ID, Qualifier - 1...10, Alternate Method detectable limit,
#          Uncertainty

pm0 <- read.table("RD_501_88101_1999-0.txt", ## file name
                  comment.char = "#",        ## Character for the comments
                  header = FALSE,            ## header
                  sep = "|",                 ## separator
                  na.strings = "")           ## not a number character
dim(pm0)
head(pm0)

cnames <- readLines("RD_501_88101_1999-0.txt", 1)  ## With the number of lines to read = 1
cnames ## String without spliting

cnames <- strsplit(cnames, "|", fixed = TRUE)  ## fixed not regular expression
cnames  ## char vector with a name for each element

names(pm0) <- cnames[[1]]  ## Assign the names to the pm0 list
head(pm0)  ## all the column names are assigned but with not valid names (with spacing)

names(pm0) <- make.names(cnames[[1]])  ## Assign valid names for the columns
head(pm0)

# We will be looking to the Sample.Value column
x0 <- pm0$Sample.Value
class(x0)
str(x0)
summary(x0)  
mean(is.na(x0))  ## Some missing values are found 11%

# Are missing values a problem? Depending on the type of question you want to answer

pm1 <- read.table("RD_501_88101_2012-0.txt", ## file name
                  comment.char = "#",        ## Character for the comments
                  header = FALSE,            ## header
                  sep = "|",                 ## separator
                  na.strings = "")           ## not a number character
dim(pm1)  ## more observations than in 199 file
names(pm1) <- make.names(cnames[[1]])  ## Assign valid names for the columns
head(pm1)
x1 <- pm1$Sample.Value
str(x1)

# Comparisson 1999-2012
summary(x0)
summary(x1)  ## mean pollutuin is lower than in 1999 bux max is higher
mean(is.na(x1))  # %5 missing values not a big deal

# Visual representation 
boxplot(x0, x1)  ## data in 2012 more spread than 1999
boxplot(log(x0), log(x1))  ## warning because of some negative numbers

# Why there are negative values? 
sumary(x1)
negative <- x1 < 0  ## logical vector true/false if it is negative val
str(negative)
sum(negative, na.rm = TRUE) ## 2647
mean(negatire, na.rm = TRUE) ## 2% not big

# Dates treatment for looking at the neg values
str(dates)
dates <- as. Dates(as.character(dates), "%Y%m%d")
str(dates)
hist(dates, "month")  ## Hist of the dates by month (winter and spring max)
hist(dates[negative]. "month")  ## Less neg values in summer

# Exploring local change by year to see this mean max relation 1999 - 2012
# This way we can control possible local changes in NY (State.Code = 36)
site0 <- unique(subset(pm0), State.Code == 36, c(Conty.Code, Site.ID)))
site1 <- unique(subset(pm1), State.Code == 36, c(Conty.Code, Site.ID)))
head(site0)

# Put the County.Code and the Site.ID as one unique code separate by "."
site0 <- paste(site0[,1], site0[,2], sep = ".")
site1 <- paste(site1[,1], site1[,2], sep = ".")
str(site0)
str(site1)
# See if some county.siteID is present in both years 1999-2012
both <- intersect(site0, site1) ## there are some

# How many observations are in each of this county.sideID
pm0$county.site <- with(pm0, paste(Conty.Code, Site.ID, sep = ".")
pm1$county.site <- with(pm1, paste(Conty.Code, Site.ID, sep = ".")
# Subset for NY state
cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)
head(cnt0) ## Only NY rows





