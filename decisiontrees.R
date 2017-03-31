dim(iris)
str(iris)

#CASE 1: training and predicting using a decision tree

#split the data into two sets
set.seed(1234)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]

#build a decision tree and use it to predict
library(party)
myFormula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
iris_ctree <- ctree(myFormula, data=trainData, controls = ctree_control(maxdepth = 3))

#check the prediction
table(predict(iris_ctree), trainData$Species)

#plot the tree
plot(iris_ctree)

# predict on test data
testPred <- predict(iris_ctree, newdata = testData)
table(testPred, testData$Species)

#CASE 2: training a decision tree, pruning the tree based on
#prediction error, making a prediction from the pruned tree

#load the body fat data
data("bodyfat", package="TH.data")
dim(bodyfat)

#split into training and test subsets, and a decision tree is built 
#on the training data
ind <- sample(2, nrow(bodyfat), replace=TRUE, prob=c(0.7, 0.3))
bodyfat.train <- bodyfat[ind==1,]
bodyfat.test <- bodyfat[ind==2,]

# train a decision tree
library(rpart)
myFormula <- DEXfat ~ age + waistcirc + hipcirc + elbowbreadth + kneebreadth
bodyfat_rpart <- rpart(myFormula, data = bodyfat.train,
                       control = rpart.control(minsplit = 10))

#print the complexity parameter table
print(bodyfat_rpart$cptable)

#plot the tree
plot(bodyfat_rpart)
text(bodyfat_rpart, use.n=T)

#select the tree with the minimum prediction error
opt <- which.min(bodyfat_rpart$cptable[,"xerror"])
cp <- bodyfat_rpart$cptable[opt, "CP"]
bodyfat_prune <- prune(bodyfat_rpart, cp = cp)

#plot the pruned tree
plot(bodyfat_prune)
text(bodyfat_prune, use.n=T)

#use the pruned tree to make predictions
DEXfat_pred <- predict(bodyfat_prune, newdata=bodyfat.test)
xlim <- range(bodyfat$DEXfat)

#plot the predictions
plot(DEXfat_pred ~ DEXfat, data=bodyfat.test, xlab="Observed",
     ylab="Predicted", ylim=xlim, xlim=xlim)
abline(a=0, b=1)


#CASE 3: random forest

#create the test and training set
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]

#train a random forest
library(randomForest)
rf <- randomForest(Species ~ ., data=trainData, ntree=100, proximity=TRUE)
table(predict(rf), trainData$Species)

#display the random forest
plot(rf)
importance(rf)
varImpPlot(rf)

#use the random forest to make predictions
irisPred <- predict(rf, newdata=testData)
table(irisPred, testData$Species)

#plot the predictions
plot(margin(rf, testData$Species))
