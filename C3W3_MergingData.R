#### C3W3 - Merging Data

# Merge data sets together
# PLOS peer review experiment data

# Download Peer review data
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile = "./data/reviews.csv", method = "curl")
download.file(fileUrl2, destfile = "./data/solutions.csv", method = "curl")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")

# The id of reviews has a solution in the id of solutions
head(reviews, 2)
head(solutions, 2)

# Merging data with merge(): merges data frames with parameters (x,y,by,by.x,by.y,all)
# Checking the names of revies there is a id that connects both tables (and other vars)
names(reviews)
names(solutions)
mergeData = merge(reviews, solutions, by.x = "solution_id", by.y = "id", all = TRUE)
head(mergeData)

# Default merge all common column names
# To know the common names in both data sets use intersect()...
intersect(names(solutions), names(reviews))
# ... and merge data with them
mergeData2 = merge(reviews, solutions, all = TRUE)

# USe join in the plyr package to merge data
df1 = data.frame( id = sample(1:10), x = norm(10))
df2 = data.frame( id = sample(1:10), y = norm(10))
arrange(join(df1, df1), id) # increasing order by id

# If you have multiple data frames
df1 = data.frame( id = sample(1:10), x = norm(10))
df2 = data.frame( id = sample(1:10), y = norm(10))
df3 = data.frame( id = sample(1:10), z = norm(10))
dfList = list(df1, df2, df3)
join_all(dfList) # merges all the data sets on the basis of common var

# Be carefull with joins (more info needed)
