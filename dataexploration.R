dim(iris)
summary(iris)

#the variance (average distance from the mean) of a variable
var(iris$Sepal.Length)

#relative frequencies of variable values
table(iris$Species)
pie(table(iris$Species))

#covariance and boxplots
cov(iris[,1:4])
boxplot(Sepal.Length~Species, data=iris)

#pairwise scatter plots
pairs(iris)

#3d plotting
install.packages("rgl")
library(rgl)
plot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width)

#parallel coordinates plot
library(MASS)
parcoord(iris[1:4], col=iris$Species)

library(lattice)
parallelplot(~iris[1:4] | Species, data=iris)

#determine the distribution
install.packages("fitdistrplus")
library(fitdistrplus)
descdist(iris$Sepal.Width, discrete = FALSE)

#visualize the distribution
hist(iris$Sepal.Width)
