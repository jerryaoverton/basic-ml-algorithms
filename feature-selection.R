#grab the titanic data
df <- as.data.frame(Titanic)

n = 2

#select the top n features
library(FSelector)
att.scores <- information.gain(Survived~ ., df)
features <- cutoff.k(att.scores, n)

#filter down the original plus the top n features
cols <- c(features, "Survived")
df.sub <- df[,cols]
