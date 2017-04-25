#### C3W3 - Reshaping Data

# The goal is tidy data once you have it:
#   Each variable forms a column
#   Each observation forms a row
#   Each table/file stores data about one kind of observation (people/hospitals)

# Start with reshaping
install.packages(reshape2)
library(reshape2)
head(mtcars)  # info of diferent cars

# Melting data frames
mtcars$carname <- rownames(mtcars)
# Melt mtcars passing the id variables and the measure variables 
carMelt <- melt(mtcars, id = c("carname", "gear","cyl"),
                measure.vars = c("mpg", "hp"))
# Creating a table with the observations of the var mpg at the top...
head(carMelt, n = 3)
# ...and observations of hp variable at the end
tail(carMelt, n = 3)

# Casting data frames (reformat the data set)
cylData <- dcast(carMelt, cyl ~ varaiable)
# carMelt data set is now showing the cyl brokendown by the variables mpg and hp
cylData
# ... and take the mean for each value
cylData <- dcast(carMelt, cyl ~ varaiable, mean)
cylData

# Average values
head(InsectsSpray)
# Take the sum of count of insects that you see for ecah of the spray
# tapply (apply count along a particular index spray and do the sum)
tapply(InsectSprays$count, InsectSprays$spray,sum)

# Another way with split
# Take the diff sprays count and split in the diff sprays
spIns = split(InsectSprays$count, InsectSpray$spray)
# You get a list of the values for each spray
spIns

# Another way with apply
# with the spIns list apply the sum
sprCount = lapply(spIns, sum)
sprCount

# We want to back to a vector and combine
unlist(sprCount)
# Combine this steps together with
sapply(spIns, sum)

# Another way with plyr package
# ddply(dataset, .(varaible to work with), work to do, how to do it)
ddply(InsectSprays, .(spray), summarize, sum = sum(count))

# Creating a new variable
# Substract the total count from every varaible creating a new variable
# New var has the same lenght than the original val
# Now how to do it part: summarize the count and sum them up with average funtion
spraySums <- ddply(InsectSprays, .(spray), summarize,
                   sum = ave(count, FUN = sum))
dim(spraySums)

# Other interesting functions
#   acast - for casting as multi-dimensional arrays
#   arrange - for faster reordering without using order() commands
#   mutate - adding new variables
