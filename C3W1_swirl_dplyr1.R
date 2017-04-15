#### C3W1 - Swirl practice

# Clean the list of variables in your workspace
rm(list = ls())

# Begin 
library(swirl)
swirl()

## Select 1: Getting and Cleaning data

## 1: Maniputlating Data with dplyr (install.packages("dplyr"))
# dplyr is a fast and powerful R package to manipulate tabular data:
# data frame and tables, databases and multidimensional arrays

# Extract the data
mydf <- read.csv(path2csv, stringsAsFactors = FALSE)
dim(mydf)
head(mydf)

# Charge dplyr package
library(dplyr)
packageVersion("dplyr")

# Load the data frame table with tabl_df and remove the original mydf data
cran <- tbl_df(mydf)
rm("mydf")

# Show the first 10 rows and the characteristics of the data table
cran

# Select the data from cran with the ip_id, package and country variables
# Without doint the cran$ip_id, cran$package and cran$country
# The columns are returned in the order we ask for

?select
select(cran, ip_id, package, country)

# It alows to use the : from one column/row to other (also in reverse order)
select(cran, r_arch:country)
select(cran, country:r_arch) 
cran

# It can specify the columns we want to throw away with a -
select(cran, -time)
select(cran,-(X:size))

# Select a subset of columns with filter() function
# Select al rows for which the package var is = swirl
filter(cran, package == "swirl")
filter(cran, r_version == "3.1.1", country == "US")

# Use the logic operators to compare
?Comparison
filter(cran, r_version <= "3.0.2", country == "IN")
filter(cran, country == "US" | country == "IN")
filter(cran, size > 100500, r_os == "linux-gnu")

# To check only rows with information use is.na() or !is.na()
is.na(c(3, 5, NA, 10))
!is.na(c(3, 5, NA, 10))
filter(cran, !is.na(r_version))

# Order the rows according to the values of particular variables with arrange()
# for order the rows of cran2 so that ip_id is in ascending order
cran2 <- select(cran, size:ip_id)
arrange(cran2, ip_id)
arrange(cran2, desc(ip_id))     # desc() for arrange in descending order

# Order according to multiple variables 
arrange(cran2, package, ip_id)
arrange(cran2, country, desc(r_version), ip_id)

# mutate() creates a new variable based on other variables of the data
cran3 <- select(cran, ip_id, package, size)
cran3
mutate(cran3, size_mb = size / 2^20)
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10) 
mutate(cran3, correct_size = size + 1000)

# summarize() collapses the dataset to a single row
# It can give zou the requested value FOR EACH GROUP in the dataset
summarize(cran, avg_bytes = mean(size))
