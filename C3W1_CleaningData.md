# Course 3 Data Science: Getting and Cleaning Data (JH University Coursera)

## Week 1

### Taking raw data and creating a tidy data set 
Each colunm is a variable and every row is an observation with a first row indicating the names of the variables

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
  * **file.exists("dirName")** will check if the dir exists
  * **dir.create("dirName")** will create a dir if it doesn't exists
  * Example: \> if(!file.exists("data")) {dir.create("data")}

### Getting data from internet
  * **download.file(url,destination_file,method)** downloads a file
  * Example: *download_data.r*
  * For *http* url
  * For *https* use *method = "curl"* on Mac
  * If the file is big it may take a while
  * Be sure to record when you download (> dateDownload <- date())
  
### Reading local flat files
  * **read.table(file, header, sep, row.names, nrows)**
  * Load flat files into memory RAM
  * Read *.csv and *.csv2
  * **read.csv(file)** stablish *sep=","* and *header = TRUE* by default
  * *quote = ""*  you get no quotes in the files, this solves a lot of problems
  * *na.strings* set the character that represents a missing value
  * *nrows* rows number to read the fiels, nrows = 10 read 10 lines
  * *skip* a number of lines before starting to read
  * Example: C3W1_read_csv.r

### Reading Excel files
  * In the download.file the extension of the destination files should be .xlsx use **read.xlsx**
  * \> library(xlsx) (if the package xlsx is not installed: \> install.packages("xlsx")
  * \> cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, header=TRUE)
  * You can read a certain number of cols and rows using colIndex and rowIndex 
  * **write.xlsx** write excel similar arguments
  * XLConnect package has more options for writting and mainipulating Excel
  * Recomended using csv and txt better than xlsx
  * Example: C3W1_read_xlsx.r
  
### Reading XML
  * Markup language for structured data for internet apps
  * Components: Markup (text structure labels) and Content (document text)
  * Tags (labels): start (<section>), end (</section>) or empty (<line-break/>)
  * Example: \<Greeting> Hello, world \</Greeting>
  * Tags can have atributes
  * Example: C3W1_read_xml.r
  * XPath is a language to extract data from xml

### Reading JSON
  * Javascript Object Notation: Lightweight data storage
  * Similar to XML
  * Example: C3W1_read_json.r

### Using data.table
  * More efficient version of data.frame
  * Create data table just like data frames
  * Example: C3W1_data_table.r
