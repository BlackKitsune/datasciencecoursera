### EXCEL (xlsx) files

home_dir <- "D:/.../Data Science/CourseraDS"
work_folder <- "/C3-W1"
work_dir <- paste(c(home_dir, work_folder), collapse = "")
setwd(work_dir)

if(!file.exists("data")) {dir.create("data")}

# instal.package("xlsx")
library(xlsx, rJava, xlsxjars)

# Download data (displays an error when run because of the url)
fileUrl_xlsx <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl_xlsx, destfile = "./data/cameras.xlsx")#, method = "curl") # Para Mac
dateDownloaded_xlsx <- date()

# Read xlsx data
cameraData_xlsx <- read.xlsx("./data/cameras.xlsx", 
                             sheetIndex = 1, header = TRUE)

# Read a specific number of columns and rows
colIndex <- 2:3
rowIndex <- 1:4
cameraData_xlsx_subset <-  read.xlsx("./data/cameras.xlsx", 
                                     sheetIndex = 1, header = TRUE,
                                     colIndex = colIndex,
                                     rowIndex = rowIndex)

setwd(home_dir)
