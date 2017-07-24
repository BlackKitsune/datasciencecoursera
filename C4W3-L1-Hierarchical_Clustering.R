### C4W3 - Hierarchical Clustering 

## Visualizing high dimensional data
## Can we find things that are close together?
#   - Close things
#   - Grouping things and visualizing
#   - Interpreting 

## Hierarchical clustering
# Is an agglomerative approach:
#  - Find closest two things > Put them together > Find next closest
# Requieres: Define a distance metric + merging approach
# Produces: A tree showing how close things are to each other

## How do we define close?
# Distance or similarity: Pick one that makes sense for your problem
#  - Continous (euclinean distance) > de = [(x1-x2)^2+...+(y1-y2)^2]^1/2
#  - Continous (correlation similarity)
#  - Binary (manhattan distance) > dm = |x1-x2|+...+|y1-y2|

## Example: Hierarchical clustering

set.seed(1234)
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

# dist()
dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)

# Take the points closest > group them > merge them > create a single cluster
# First one is the 5,6 points, then 10,11...
# Finaly we will have a tree diagram: hclust()

hClustering <- hclust(distxy)
plot(hClustering)

# Cut the plot at some point to see how many branches of the tree

## Prettier dendrograms
# Modification of plclust for plotting hclust objects in colour
# Arguments: hclust(hclust object), 
#            lab(char vector labels tree leaves), 
#            lab.col (colour of the labels),
#            NA = default (device foreground colour)
#            hang(as in hclust & pclust Side)
# Effect: Display hierarchical cluster with coloured leaf labels

myclust <- function(hclust,
                    lab = hclust$labels,
                    lat.col = rep(1, length(hclust$labels)),
                    hang = 0.1, ...) {
           y <- rep(hclust$height, 2)
           x <- as.numeric(hpclust$merge)
           y <- y[which(x < 0)]
           x <- x[which(x < 0)]
           x <- abs(x)
           y <- y[order(x)]
           x <- x[order(x)]
           plot(hclust, labels = FALSE, hang = hang, ...)
           text(x = x, 
                y = y[hclust$order] - (max(hacluster$height)* hang),
                labels = lab[hcluster$order],
                col = lab.col[hclust$order],
                str = 90,
                adj = c(1, 0.5),
                xpd = NA, ...)
}

dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
myplclust(hclustering, 
          lab = rep(1:3, each = 4),
          lab.col = rep(1:3, each = 4))

## Merging point - complete() > complete link = distance between the farest point
## Merging point - average > distance between the center of gravity of points

# heatmap() > visuslization of high dimension data
dataFrame <- data.frame(x = x, y = y)
set.seed(143)
dataMAtrix <- as.matrix(dataFrame)[sample(1:12), ]
heatmap(dataMatrix)

## Summary:
#   - Gives an idea of the relationships between variables/observations
#   - The picture may be unstable: 
#       * Change a few points
#       * Have different missing values
#       * Pick different distance
#       * Change the merging strategy
#       * Change the scale of points for one variable
#   - But be deterministic
#   - Choosing where to cut is not that obvious
#   - Should be primarly used for exploration                    


