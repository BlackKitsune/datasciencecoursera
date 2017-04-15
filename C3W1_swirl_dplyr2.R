#### C3W1 - Swirl practice

# Clean the list of variables in your workspace
rm(list = ls())

# Begin 
library(swirl)
swirl()

# 2: Grouping and Chaining with dplyr

library(dplyr)

# The main idea behind grouping data is that you want to break up your
# dataset into groups of rows based on the values of one or more
# variables. The group_by() function is reponsible for doing this.

# The dataset mydf is 'data frame tbl' using the tbl_df() function and store
# the result in a object called cran.

cran <- tbl_df(mydf)
rm("mydf")
cran

# Group the data by package name
?group_by
by_package <- group_by(cran, package)
by_package # At the top of the info see "Groups: package [6, 023]

# The mean of all values in the size column = mean download size for package
summarize(by_package, mean(size))


### Package summary
# Compute four values, in the following order, from
# the grouped data:
#
# 1. count = n()
# 2. unique = n_distinct(ip_id)
# 3. countries = n_distinct(country)
# 4. avg_bytes = mean(size)
#
# A few thing to be careful of:
#
# 1. Separate arguments by commas
# 2. Make sure you have a closing parenthesis
# 3. Check your spelling!
# 4. Store the result in pack_sum (for 'package summary')
#
# You should also take a look at ?n and ?n_distinct, so
# that you really understand what is going on.

?n # Number observations (rows) in the current group (summarize,mutate,filter)
?n_distinct # Count the num of unique values in a set of vector

pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

# count = total num or rows (downloads) for each package
# unique =  total num of unique downloads for each package for different ip_id
# countries =  num countries each package was downloaded
# avg_bites = mean download size (in bytes) for each package

pack_sum

# Isolate the top 1% of packages, based on the total num of downloads (count)
# Bottom 99% packages is th 0.99 sample quantile
quantile(pack_sum$count, probs = 0.99) # 99%  is 679.56

# Isolate those packages which had more that 679 total downloads with filter()
top_counts <- filter(pack_sum, count > 679)
top_counts # 61 packages in our top 1%
View(top_counts)

# arrange() rows of top_counts based on count as measure of popularity
top_counts_sorted <- arrange(top_counts, desc(count))
View(top_counts_sorted) # First one is ggplot2

# More interested will be the number of unique downloads
quantile(pack_sum$unique, probs = 0.99) # 99% is 465
top_unique <- filter(pack_sum, unique > 465)
View(top_unique) # First one is bitops
top_unique_sorted <- arrange(top_unique, desc(unique))
View(top_unique_sorted) # First one is Rcpp

# Other metric of popularity is num countries that downloaded the package
# With a method called "chaining" (piping) = string function calls


### Chaining example
# Don't change any of the code below. Just type submit()
# when you think you understand it.

# We've already done this part, but we're repeating it
# here for clarity.

by_package <- group_by(cran, package)
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

# Here's the new bit, but using the same approach we've
# been using this whole time.

top_countries <- filter(pack_sum, countries > 60)

# Sorted by countries and use average as tie breaker
result1 <- arrange(top_countries, desc(countries), avg_bytes)

# Print the results to the console.
print(result1)

# Accomplish same results but avoid saving intermediate results

# Don't change any of the code below. Just type submit()
# when you think you understand it. If you find it
# confusing, you're absolutely right!

result2 <-
        arrange(
                filter(
                        summarize(
                                group_by(cran,
                                         package
                                ),
                                count = n(),
                                unique = n_distinct(ip_id),
                                countries = n_distinct(country),
                                avg_bytes = mean(size)
                        ),
                        countries > 60
                ),
                desc(countries),
                avg_bytes
        )

print(result2)


# Read the code below, but don't change anything. As
# you read it, you can pronounce the %>% operator as
# the word 'then'.
#
# Type submit() when you think you understand
# everything here.

result3 <-
        cran %>%
        group_by(package) %>%
        summarize(count = n(),
                  unique = n_distinct(ip_id),
                  countries = n_distinct(country),
                  avg_bytes = mean(size)
        ) %>%
        filter(countries > 60) %>%
        arrange(desc(countries), avg_bytes)

# Print result to console
print(result3)

# Rcpp top downloads from 84 countries

## Select the variables
# select() the following columns from cran. Keep in mind
# that when you're using the chaining operator, you don't
# need to specify the name of the data tbl in your call to
# select().
#
# 1. ip_id
# 2. country
# 3. package
# 4. size
#
# The call to print() at the end of the chain is optional,
# but necessary if you want your results printed to the
# console. Note that since there are no additional arguments
# to print(), you can leave off the parentheses after
# the function name. This is a convenient feature of the %>%
# operator.

cran %>%
        select(ip_id,country,package,size) %>%
        print


## Create a new column with the size in MB
# Use mutate() to add a column called size_mb that contains
# the size of each download in megabytes (i.e. size / 2^20).
#
# If you want your results printed to the console, add
# print to the end of your chain.

cran %>%
        select(ip_id, country, package, size) %>%
        mutate(size_mb = size / 2^20)

## Filter the values
# Use filter() to select all rows for which size_mb is
# less than or equal to (<=) 0.5.
#
# If you want your results printed to the console, add
# print to the end of your chain.

cran %>%
        select(ip_id, country, package, size) %>%
        mutate(size_mb = size / 2^20) %>%
        # Your call to filter() goes here
        filter(size_mb <= 0.5)

## Arrange the values
# arrange() the result by size_mb, in descending order.
#
# If you want your results printed to the console, add
# print to the end of your chain.

cran %>%
        select(ip_id, country, package, size) %>%
        mutate(size_mb = size / 2^20) %>%
        filter(size_mb <= 0.5) %>%
        # Your call to arrange() goes here
        arrange(desc(size_mb))
