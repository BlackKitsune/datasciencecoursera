#### C3W2 - Reading data from the Web

# Webscraping: Programtically extracting data from the HTML code of websites
# Doing so can be against the terms of the web

## Getting data of webpages - readLines()
# Open a conection to a url
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
# Use the readLines to read that htmil page
htmlCode = readLines(con)
# Close the conection
close(con)
# See the contents: They are very hard to read unformated text
htmlCode

## Parsing with XML package
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
# use the useInternalNodes to get the complete structure out
html <- htmlTreeParse(url, useInternalNodes = T)
# Look for a particular node to see that element as "//title"
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

## GET from the httr package
library(httr) ; html2 = GET(url)
# Extract the content as a text file
content2 = content(html2, as="text")
# Parse out that text
parsedHtml = htmlParse(content2, asText = TRUE)
# Extract out the title form the file
xpathSApply(parsedHtml, "//title", xmlValue)

## Accessing websites with passwords
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
# it will give you and status error 400 to authenticate
pg1

# Use the authenticate attribute to do so
pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user", "passwd"))
# it will give you and status error 200, access to the file
pg2
# So you can look into the contents of the file
names(pg2)

# Using handles you can save the authentication across multiple accesses
google = handle("http://google.com")
# GET that handle for a specific path
pg1 = GET(handle = google, path="/")
pg1 = GET(handle = google, path="search")
