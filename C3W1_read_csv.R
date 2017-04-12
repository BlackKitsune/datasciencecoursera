# Download and read csv data

home_dir <- "D:/Isabelita/Data Science/CourseraDS"
work_folder <- "/C3-W1"
work_dir <- paste(c(home_dir, work_folder), collapse = "")
setwd(work_dir)


#### Download file from the web

# Create a data folder to storage data
if(!file.exists("data")) {dir.create("data")}

# Create a variable with the name of the URL website
fileUrl_csv <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

# Download the data fro fileURL into a desination file with curl method
download.file(fileUrl_csv, destfile = "./data/cameras.csv")#, method = "curl") # Para Mac

# Make a list of the files in data
files_downloaded <- list.files ("./data")

# Take the download date in case of changes in the files
dateDownloaded_csv <- date()

#Read data
cameraData_csv <- read.table("./data/cameras.csv", sep = ",", header = TRUE)

setwd(home_dir)
