### C3W3 - Subsetting and sorting

# Manipulate data once is downloaded

## Subsetting review
# Stablish a X data frame with some data inside
set.seed(13435)
X <- data.frame("var1" = sample(1:5), 
                "var2" = sample(6:10),
                "var3" = sample(11:15))
X <- X[sample(1:5),]; X$car2[c(1,3)] = NA

# Show data frama
X

# Subset a specific col 
X[,1]

# Subset by a specific col name
X[,"var1"]

# Subset by row/col name at the same time
X[1:2,"var1"]

# Use logical statements and/or
X[X$var1 <= 3 & X$var3 > 11]
X[X$var1 <= 3 | X$var3 > 15]

# Dealing with NA
X[which(X$var2 > 8)]

# Sorting
sort(X$var1)
sort(X$var1, decreasing = TRUE)
sort(X$var1, na.last = TRUE) # NA at the end

# Ordering
X[order(X$var1),]  # Order variables depending on var1 values
X[order(X$var1, Xvar3),]  # Order by multiple variables in order

# Ordering with plyr
library(plyr)
arrange(X,var1)
arrange(X, desc(var1))  # decreasing order

# Add row/col
X$var4 <- rnorm(5)

# Add row/col using cbind
Y <- cbind(X, rnorm(5)) # for columns
Y <- rbind(X, rnorm(5)) # for rows
