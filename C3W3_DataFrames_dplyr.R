#### C3W3 - Data Frames with dplyr

# Manipulate data frames with dplyr: arrange, filter, select, mutate, rename
# dplyr is the optimized version of plyr package
# Data frame is a key data structure in statistics and in R
#   One observation per row
#   Each column is a varaible


# dplyr Verbs: 
#   select = return a subset of the columns of a data frame
#   filter = extract a subset of rows from a data frame based on logical conditions
#   arrange = reorder rows of a data frame
#   rename = rename variables in a data frame
#   mutate = add new variables/columns or transform existing variables
#   summarise / summarize = generate summary statistics of different variables (strata)

# dplyr properties:
#   The first argument is the data frame
#   Then what to do with it, refering to the columns using the name without $
#   Result is a new data frame
#   Data frames must be properly formatted and annotated 

### Basic tools
install.packages("dplyr")
library(dplyr)

## Function select(): select a range of the data set
# Take a data set and study the content of it
chicago <- readRDS("chicago.rds")
dim(chicago)
str(chicago)
names(chicago)

# look at the columns between two of them
head(select(chicago, city:dptp))
# use the - to avoid some column
head(select(chicago, -(city:dptp))

# The equivalent code to do this in R without dplyr
# Find the indexes for city and dptp columns...
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
# ... and take the negative of those indexes
head(chicago[, -(i:j)])

## Function filter(): Subset using logical conditions
# Take al the rows in one column where the contents of the col are > something
chic.f <- filter (chicago, pm25tmean2 > 30)
head(chic.f, 10)
# Take multiple col to create more complicated sequences
chic.f <- filter (chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f, 10)

## Function arrange(): reorder data in the data frame
# Arrange the data with the date
chicago <- arrange(chicago, date)
head(chicago)
tail(chicago)
# Descending order
chicago <- arrange(chicago, desc(date))
head(chicago)
tail(chicago)

## Function rename()
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago)

## Function mutate(): Change variables in the data frame
chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
head(select(chicago, pm25, pm25dtrend))

## Function group_by(): Group according to a categorical variable
# Create the variable to categorize...
chicago <- mutate(chicago, tempcat = factor(1*(tmpd > 80, labels = c("cold", "hot")))
# ... and group by that new variable
hotcold <- group_by(chicago, tempcat)
hotcold
# Summarize the new var, to know the mean pm25, the max of o3 and the median of no2
summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE),
                   o3 = max(o3mean2),
                   no2 = median(no2tmean2))
# Categorize using the year
chicago <- mutate(chicago, zear = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
# Summarizing the same by year, you can see the trend on time
summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE),
                   o3 = max(o3mean2),
                   no2 = median(no2tmean2))

## Pipeline operator: %>%
# Takes the ouput of the sequence and operates with it without intermediate variables
chicago %>% mutate(month = as.POSIXlt(date)$mon +1) %>% group_by(month)
        %>% summarize(pm25 = mean(pm25, na.rm = TRUE),
                   o3 = max(o3mean2),
                   no2 = median(no2tmean2))
                   
# Additional benefits: can work with data.table and SQL interface
