require(mvtnorm)

#define the correlation matrix
S <- matrix(c(1,.9,.9,1),2,2)

#create a set of random, guaussian variable correlated according to the matrix
AB <- rmvnorm(mean=c(0,0),sig=S,n=10000)

#convert the variables to a uniform distribution
#check using hist(U[,1]) or hist(U[,2])
U <- pnorm(AB)

#convert the variables to different distributions
x <- qgamma(U[,1],2) #x is gamma distributed
y <- qbeta(U[,2],1,2) #y is beta distributed

#plot the variables to see that they correlate
plot(x,y)

#check the variable correlation
cor(x,y)


