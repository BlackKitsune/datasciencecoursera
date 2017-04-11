# Course 3 Data Science: Getting and Cleaning Data (JH University Coursera)

## Week 1

### Taking raw data and creating a tidy data set 
Each colunm is a variable and every row is an observation with a first row 
indicating the names of the variables

### The code book should include 
  * Information about the variables (units), 
  * Choices that you take and the experimental study

### The Instructions list should be in a R script (or python)
  * The input of the script is the raw data 
  * The output is the processed tidy data
  * There are no parameters to the script
  
### Downolading files
  * Get/Set your working directory: **getwd()** and **setwd()**
  * Relative path setwd("./data"), setwd("../")
  * Absolute path setwd("/Users/jtleek/data/")
  * For windows \\ backslash

### Directories
  * **file.exists("dirName")** will check if th dir exists
  * **dir.create("dirName")** will create a dir if it doesn't exists
  * Example: > if(!file.exists("data")) {dir.create("data")}

### Getting data from internet
  * **download.file(url,destination_file,method)** downloads a file
  * Example: *download_data.r*
  
  
  



