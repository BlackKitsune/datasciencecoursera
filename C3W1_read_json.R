# Read XML files

home_dir <- "D:/.../Data Science/CourseraDS"
work_folder <- "/C3-W1"
work_dir <- paste(c(home_dir, work_folder), collapse = "")
setwd(work_dir)

if(!file.exists("data")) {dir.create("data")}

#install.packages("jsonlite")
library(jsonlite)

# Download the xml data and read that data
fileUrl <- "http://api.github.com/users/jtleek/repos"
jsonData <- fromJSON(fileUrl)
names(jsonData)
names(jsonData$owner)
jsonData$owner$login

myjson <- toJSON(iris, pretty = TRUE)
cat(myjson)
iris2 <- fromJSON(myjson)
head(iris2)


setwd(home_dir)
