#### Download file from the web

home_dir <- "D:/..../Data Science/CourseraDS"
work_folder <- "/C3-W1"
work_dir <- paste(c(home_dir, work_folder), collapse = "")
setwd(work_dir)

# Create a data folder to storage data
if(!file.exists("data")) {dir.create("data")}

# Create a variable with the name of the URL website
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

# Download the data fro fileURL into a desination file with curl method
download.file(fileUrl, destfile = "./data/cameras.csv")#, method = "curl")

# Make a list of the files in data
files_downloaded <- list.files ("./data")

# Take the download date in case of changes in the files
dateDownloaded <- date()

setwd(home_dir)
