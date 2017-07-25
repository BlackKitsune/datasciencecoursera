#### C4W3 - L2 - K means clustering and Dimension reduction

## K-means Clusterring
# A partitioning approach:
#   - Fix a number of clusters
#   - Get "Centroids" of each cluster (center of gravity)
#   - Assign things to closest centroid
#   - Recalculate centroids
# Requires: defined distance metric + num clusters + initial guess cluster centroid
# Produces: Cluster centroids final estimate + Assignment each point to cluster

# K - Means example
set.seed(1234)
par(mar = c(0, 0, 0, 0,))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as. character(1:12))

# 1. Starting centroids: Randonmly assigned
# 2. Assign to closest centroid the clusters
# 3. Recalculate the centroinds (assigning the mean to that cluster for ex.)
# 4. Recalculate the centroinds (update centroid locations)...

# kmeans(x, centers, iter.max, nstart): implement the kmean algorith
dataFrame <- data.frame(x, y)
kameansObj <- kmeans(dataFrame, centers = 3) # With 3 centroids
names(kmeanObj) # object with different elemnts
kmeanObj$cluster # for each point what is his cluster

# plot results
par(mar = rep(0.2, 4))
plot(x, y, col = kmeanObj$cluster, pch = 19, cex = 2)
points(kmeanObj$centers, col = 1:3, pch =3, cex = 3, lwd = 3)

## Heatmaps
set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sanple(1:12), ]
kmeanObj2 <-  kmeans(dataMAtrix, centers = 3)
par(mfrow = c(1,2), mar = c(2,4,0.1,0.1))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n")
image(t(dataMatrix)[, order(kmeanObj$cluster)], yaxt = "n")

## Summary
#   - Requires a number of cluster
#       * Pick by eye/intuition
#       * Pick by cross validation/information theory
#       * Determining the number of clusters
#   - It is not deterministic: Different clusters and num. of iterations

### Dimension Reduction

## Principal Components Analysis (PCA) and Singular Value Decomposition (SVD)

# Matrix data (random data)
set.seed(12345)
par(mar = rep(0.2, 4)
dataMAtrix <- matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(dataMatrix)[, nrow(DataMatrix):1])

# Cluster the data (no paterns on the data because they are random)
par(mar = rep(0.2, 4))
heatmap(dataMatrix)

# Add patter in the data set
set.seed(678910)
for(i in 1:40) {
      # Flip a coin
      coinFlip <- rbinom(1, size = 1, prob = 0.5)
      # If coin is heads add a common pattern to that row
      if (coinFlip) {
          dataMatrix[i, ] <- dataMAtrix[i, ] + rep(c(0, 3), each = 5)
      }
 }
 
 par(mar = rep(0.2, 4))
 image(1:10, 1:40, t(dataMatrix)[, nrow(DataMatrix):1]) # See a pattern
 
 # Clusterd data again
par(mar = rep(0.2, 4))
heatmap(dataMatrix)

# Patterns in rows and columns

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]
par(mfrow = c(1,3))
image(t(dataMatrix$Ordered)[, nrow(dataMatrixOrdered):1])
plot(rowMeans(DataMatrixOrdered), 40:1, , xlab = "Row Mean", zlab = "Row", pch = 19)
plot(colMeans(DataMatrixOrdered), xlab = "Column", zlab = "Column Mean", pch = 19)

## Related problems
# You have multivariate variables x1, ..., xn so x1 = (X11, ..., x1m)
# Find a multivariate variables set that is uncorrelated and explain variance
# If you put all the variables together in one matrix, find the best matrix 
# created with fewer variables (lower rank) that explains the original data
# The first goal is statistical and the secon goal is data compression

## Realated solutions: PCA/SVD
# SVD: If X is a matrix with each variable in a col and each observation in a row
# then SVD is a matrix decomposition X = UDV ^T
# Where the columns of U are orthogonal (left singular vectors), the columns of V
# are orthogonal (right singular vector)  and D is a diagonal matrix (sigula vals)

# PCA: The principal components are equal to the right singular values if you first
# scale (substract the mean, divide by the standar deviation) the variables.

## Components of the SVD - u and v
svd1 <- svd(scale(dataMAtrixOrdered))
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd1$u[, 1], 40:1,  , xlab = "row", ylab = "First left singular vector",
     pch = 19)
plot(svd$v[, 1], xlab = "col", ylab = "First right singular vector",pch = 19)

# Variance explained
par(mfrow = c(1, 2))
plot(svd1$d, xlab = "col", ylab = "singular vaule", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "col", ylab = "Variance explained prop.", pch = 19)

# Relationship to principal components (They are doing the same thing)
svd1 <- svd(scale(dataMAtrixOrdered))
pca1 <- prcomp(dataMatrixOrdered, scale = TRUE)
plot(pca1$rotation[, 1], 
     svd1$v[, 1], 
     pch = 19, 
     xlab = "Principal component 1",
     ylab = "Right singular vector 1")
abline(c(0,1))

# Component of the SVD - Variance explained
constantMatrix <- dataMatrixOrdere*0
for(i in 1:dim(dataMatrixOrdered)[1]{constantMatrix[i, ] <- rep(c(0,1), each=5)}
svd1 <- svd(constantMatrix)
par(mfrow=c(1,3))
image(t(constantMatrix)[,nrow(constantMatrix):1])
plot(svd1$d, xlab = "col", ylab = "singular vaule", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "col", ylab = "Variance explained prop.", pch = 19)
    
# What if we add a second pattern
set.seed(678910)
for(i in 1:40) {
      # Flip a coin
      coinFlip1 <- rbinom(1, size = 1, prob = 0.5)
      coinFlip2 <- rbinom(1, size = 1, prob = 0.5)
      # If coin is heads add a common pattern to that row
      if (coinFlip1) {
          dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 5), each = 5)
      }
      if (coinFlip2) {
          dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 5), 5)
      }
 }
 hh <- hclust(dist(dataMatrix))
 dataMatrixOrdered <- dataMatrix[hh$order, ]
    
 # Singular value dcomposition - true patterns
svd2 <- svd(scale(dataMAtrixOrdered))
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rep(c(0,1), each=5), pch =19, xlab = "Column", ylab = "Pattern 1")
plot(rep(c(0,1), 5), pch =19, xlab = "Column", ylab = "Pattern 2")
    
# v and patterns of variance in rows
svd2 <- svd(scale(dataMAtrixOrdered))
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd2$v[, 1], pch =19, xlab = "Column", ylab = "First right singular vector")
plot(svd2$v[, 2], pch =19, xlab = "Column", ylab = "Second right singular vector")
    
# d and variance explained
svd1 <- svd(scale(dataMAtrixOrdered))
par(mfrow = c(1, 2))
plot(svd1$d, xlab = "col", ylab = "Singular value", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "col", ylab = "Percent variance explained", pch = 19)

# Missing values
dataMatrix2 <- dataMatrixOrdered
dataMatrix2[sample(1:100, size=40, replace=FALSE)] <- NA  ## insert random missing data
svd1 <- svd(scale(dataMatrix2))  ## Does not work!! Error: infinite of missing values in x
    
# Imputing {inpute} (no effect on the running of the svd)
library(impute)  ## Availabel from bioconductor.org
dataMatrix2 <- dataMatrixOrdered
dataMatrix2[sample(1:100, size=40, replace=FALSE)] <- NA
dataMatrix2 <- inpute.knn(dataMatrix2)$data
svd1 <- svd(scale(dataMatrix2))
svd2 <- svd(scale(dataMatrix2))
par(mfrow=c(1,2)
plot(svd1$v[,1], pch=19)
plot(svd2$v[,1], pch=19)

## Face example (lower representation of the face
load("data/face.rda")
image(t(faceData[, nrow(faceData):1])
# Variance explained
svd1 <- svd(scale(faceData))
plot(svd1$d^2/sun(svd1^2), pch=19, xlab="Singular vector", ylab = "Variance explained")
# Create approximations: svd1$d[1] is a constant (%*% matrix multiplication)
approx1 <- svd1$u[, 1] %*% t(svd1$v[,1]) * svd1$d[1]
# In these examples we need to make the diagonal matrix out of d
approx5 <- svd1$u[,1:5] %*% diag(svd1$d[1:5]) %*% t(svd1$v[,1:5])
approx10 <- svd1$u[,1:10] %*% diag(svd1$d[1:10]) %*% t(svd1$v[,1:10])
# Plot approximations
par(mfrow=c(1,4))
image(t(approx1)[, nrow(approx1):1], main="(a)") # with first singular vector
image(t(approx5)[, nrow(approx5):1], main="(b)") # with five first singular vector
image(t(approx10)[, nrow(approx10):1], main="(c)")
image(t(faceData[, nrow(faceData):1], main ="Origianl data)
# If you use 5-10 first singular vectors you will obtain a good approximation

## Summary
#     - Scale matters
#     - PC's/SV's may mix real patterns
#     - Can be conputationally intensive
#     - Advanced data analysis from an elementary point of view
#     - Elements of statistical learning
#     - Alternatives: factor / independent component / latent semantic analysis
