#### C3W2 - HDF5

# hdf5 can be used to optimize reading/writing from disc in R
# Used for storing large data sets
# Supports storing a range of data types
# Heirarchical data format
# groups: zero or more data sets and metadata
#       header(name,list(attributes))
#       symbol_table(list(objects in the group))
# datasets: multidimensional arraz of data elements with metadata
#       header(name, datatype, dataspace, storage_layout)
#       data_array(data)

# Install packages from Bioconductor big data packages
source("http://bioconductor.org/biocLite.R")
# Load rhdf5 package
biocLite("rhdf5")

# Can be used to interface with hdf5 data sets
library(rhdf5)


## Create files and groups inside that file
# Create a dataset with hdf5
created = h5createFile("example.h5")
created  # > TRUE

# Create groups withing the file
created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")

# Create a subgroup of "foo" called "foobaa"
created = h5createGroup("example.h5", "foo/foobaa")

# Show results
h5ls("example.h5")

## Write to groups:
# Create a matrix A and write it inside a group (foo)
A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A")

# Can create multidimensional array B and add attributes
B = array(seq(0.1, 2.0, by=0.1),dim=c(5,2,2))
attr(B, "scale") <- "liter"
# Add this array to a particular subgroup
h5write(B, "example.h5", "foo/foobaa/B")

# Show results
h5ls("example.h5")

## Write a data set
# Create a data frame and add it to a subgroup
df = data.frame(1L:5L, seq(0,1,length.out=5),
                c("ab","cde","fghi", "a", "s"),
                stringsAsFactors = FALSE)

# Write that df to the top level group passing the variable name
h5write(df, "example.h5", "df")
h5ls("example.h5")

## Reading data
readA = h5read("example.h5", "foo/A")
readB = h5read("example.h5", "foo/foobaa/B")
readdf = h5read("example.h5", "df")
readA

## Writing and reading chunks
# write to the dataset A inside foo group and give the indexes
h5write(c(12,13,14),"example.h5", "foo/A", index=list(1:3,1))
h5read("example.h5", "foo/A")
