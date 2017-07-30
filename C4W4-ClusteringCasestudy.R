### C4W4 - Clustering case study - Sangsung smartphone data

## Understanding Human activity with smart phones

# Samsung training dataset: Predicting people movements bsed on smartphone data
# derived from 3D position accelerometer

# Slightly processed data
load("data/samsungData.rda")
names(sansungData)[1:12]  ## Observations = row, features/variables = columns
table(samsungData$activity) ## laying,sitting,standing,walk,walkdonw, walkup

# Plotting average accelartion for firts subject (factorize activity)
par(mfrow = c(1,2), mar = c(5,4,1,1))
samsungData <- transform(samsungData, activity = factor(activity))
sub1 <- subset(samsungData, subject == 1)
plot(sub1[,1], col = sub1$activity, ylab = names(sub1)[1])
plot(sub1[,2], col = sub1$activity, ylab = names(sub1)[2])
legend("bottonright", legend = unique(sub1$activity), 
       col = unique(sub1$activity), pch = 1)

# Clustering based on average acceleration
source("myplclust.R")
distanceMatrix <- dist(sub1[,1:3])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col = unclass(sub1$activity))

# Why is the dendrogram produced using avg.acc. features uninformative?
# The avg.acc. features dont discriminate between the six different behaviours

# Plotting max body acc. (col 11 = x, col 12 = y) for the first subject 
par(mfrow = c(1,2))
plot(sub1[,10], pch = 19, col = sub1$activity, ylab = names(sub1)[10])
plot(sub1[,11], pch = 19, col = sub1$activity, ylab = names(sub1)[11])

# Clustering based on maximum acceleration
source("myplclust.R")
distanceMatrix <- dist(sub1[,10:12])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col = unclass(sub1$activity))

# Clear cluster based on moving/no-moving differentiation
# But it is hard to discriminate between each activity

## Singular Value Decomposition (SVD)
svd1 = svd(scale(sub1[, -c(562,563)]))
par(mfrow = c(1,2))
plot(svd1$u[,1], col = sub1$activity, pch = 19) # first singular vector
plot(svd1$u[,2], col = sub1$activitz, pch = 19) # second sigular vector

# First singular vector diferentiates between moving/non-moving activities
# Second singular vector is more difficult to interpret

# Find maximum contributor (second right singular vector)
plot(svd1$v[, 2], pch = 19)

# Clustering with maximum contributer
maxContrib <- which.max(svd1$v[,2])
distanceMatrix <- dist(sub1[, c(10:12, maxContrib)])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col = unclass(sub1$activity))

# Separates between the moving activities but not the non-moving
names(samsungData)[maxContrib] ## fbodyAcc.meanFreqZ

## K-means clustering (nstart =1, first try) with 6 clustering centers
kClust <- kmeans(sub1[, -c(562,563)], centers = 6)
table(kClust$cluster, sub1$activity)

# It is mixed in some activities 

## K-means clustering (nstart =1, second try)
kClust <- kmeans(sub1[, -c(562,563)], centers = 6, nstart = 1)
table(kClust$cluster, sub1$activity)

# The arrange is a little different but some of the activities dont cluster easily

## K-means clustering (nstart = 100, first try)
kClust <- kmeans(sub1[, -c(562,563)], centers = 6, nstart = 1)
table(kClust$cluster, sub1$activity)

# nstart = 100  we take 100 starting different values
# the clustering is a little better than the second try of nstart = 1
# the walk activities are completely clusterd

## K-means clustering (nstart = 100, secod try)
kClust <- kmeans(sub1[, -c(562,563)], centers = 6, nstart = 1)
table(kClust$cluster, sub1$activity)

# Second try a little bit better results



