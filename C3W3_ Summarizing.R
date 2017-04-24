#### C3W3 - Summarizing Data

# Getting data from the web

# Create a folder data in case it does not exist
if(!file.exists("./data")){dir.create("./data")}

# Donwload the data form a url
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(url = fileUrl,
              destfile = "./data/restaurants.csv") #, method = curl) for mac
restData <- read.csv("./data/restaurants.csv")

# Look at a a bit of the data
head(restData, n = 3)
tail(restData, n = 3)

# Make summary (statistic data and others)
summary(restData)

# Mpre in depth information (about the data, dim, class...)
str(restData)

# Quantiles of quantitative variables (quantitative information)
quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))

# MAke table 
table(restData$zipCode, useNA = "ifany")  # useNA to not miss any missing values
table(restData$councilDistrict, restData$zipCode) # two variable table

# Check for missing values
sum(is.na(restData$councilDistrict)) # if = 0 then not missing values
any(is.na(restData$councilDistrict)) # if = FALSE then not missing values
all(restData$zipCode > 0)  # if every value staisfy the condition

# Row/col sums
colSums(is.na(resData)) 
rowSums(is.na(resData))
all(colSums(is.na(resData)) == 0)  # if = 0 then no missing values

# Values with specific characteristics
table(restData$zipCode %in% c("21212")) # restaurants at this zip code 
table(restData$zipCode %in% c("21212", "21213"))
# Subset that data
restData[restData$zipCode %in% c("21212", "21213"),]

# Cross tabs
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions) # create a data set with that data
summary(DF)

# Find where the relationships are in this dataset
xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt

# Flat tables
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~., data = warpbreaks)
xt # There is 3 variables replicate, tension and wool within 2D tables
ftable(xt)  # summarize the table in a more compact table

# Size of a data set
fakeData = rnorm(1e5)
object.size(fakeData) # no so readable
print(object.size(fakeData), units = "Mb")  # specify units
