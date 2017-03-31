#grab the titanic data
df <- as.data.frame(Titanic)

#process the data for rule mining
titanic.raw <- NULL
for (i in 1:4) {titanic.raw <- cbind(titanic.raw, rep(as.character(df[,i]), df$Freq))}
titanic.raw <- as.data.frame(titanic.raw)
names(titanic.raw) <- names(df)[1:4]

# find association rules with default settings
library(arules)
rules.all <- apriori(titanic.raw)

#inspect the rules
rules.all
inspect(rules.all)

# rules with rhs containing "Survived" only
rules <- apriori(titanic.raw, control = list(verbose=F),
                 parameter = list(minlen=2, supp=0.005, conf=0.8), 
                 appearance = list(rhs=c("Survived=No", "Survived=Yes"), 
                                   default="lhs"))

#round the rule metrics to 3 digits
quality(rules) <- round(quality(rules), digits=3)

#sort the rules by lift
rules.sorted <- sort(rules, by="lift")

#inspect the rules
inspect(rules.sorted)

# find redundant rules
subset.matrix <- is.subset(rules.sorted, rules.sorted)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)

# remove redundant rules
rules.pruned <- rules.sorted[!redundant]
inspect(rules.pruned)

#plot the rules
#install.packages("arulesViz")
library(arulesViz)
plot(rules.pruned, method = "graph")
plot(rules.pruned, method="paracoord", control=list(reorder=TRUE))