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

