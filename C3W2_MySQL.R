#### C3W2 - MySQL

# install.packages('RMySQL')
# library(RMySQL)

## Connecting and listing databases
# dbConnect command connect to a MySQL database
# user and host are necessary as arguments
ucscDb <- dbConnect(MySQL(),user='genome',
                 host='genome-mysql.cse.ucsc.edu')

# You apply a query to that database
# and disconnect from the server
result <- dbGetQuery(ucscDb,'show databases;'); dbDisconnect(ucscDb);

# You will receive a TRUE as a response to the diconnect
# in result zou obtain a list of abailable databases within MySQL server

## Connection to hg19 and listing tables
# We focus into db = 'hg19' database from human genome
hg19 <- dbConnect(MySQL(),user='genome', db = 'hg19',
                    host='genome-mysql.cse.ucsc.edu')

# List all the tables into 
allTables <- dbListTables(hg19)
length(allTables)
# Each table corresponds to a different dataset
allTables[1:5]

## Get dimensions of a specific table
# We are centered in a particular table 'affyU133Plus2'
# List all fields (rows) of this table
dbListFields(hg19, 'affyU133Plus2')

# List how may columns (count all the references)
dbGetQuery(hg19, 'select count(*) from affyU133Plus2')

## Read from the table
affyData <- dbReadTable(hg19, 'affyU133Plus2')
head(affyData)

## Select a specific subset
# Select from database hg19 all the observations from table 'affyU133Plus2'
# where the variable misMatches (column) is between 1 and 3
query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)

# You only want the top 10 records of the table
# and remember to clean the query
affyMisSmall <- fetch(query, n=10); dbClearResult(query);
dim(affyMisSmall)

# Close the connection
dbDisconnect(hg19)

## Resources
# Only use the select command not ensembl
