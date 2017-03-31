#use the iris data
iris2 <- iris

#set the species column to null, we'll try to guess it from clustering
iris2$Species <- NULL

#create 3 clusters from k-means
kmeans.result <- kmeans(iris2, 3)
kmeans.result

#show how the clusters align with the species
table(iris$Species, kmeans.result$cluster)

#plot the clusters
plot(iris2[c("Sepal.Length", "Sepal.Width")], col = kmeans.result$cluster)

# plot cluster centers
points(kmeans.result$centers[,c("Sepal.Length", "Sepal.Width")], 
       col = 1:3, pch = 8, cex=2)