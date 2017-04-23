#create a document term matrix data frame from csv file containing unstructured text

#read in the customer complaints
data <- read.csv("consumer_complaints_population.csv") 

#filter the data down to the necessary columns
cols <- c("Complaint.ID", "Product", "Consumer.complaint.narrative")
data <- data[,cols]

#build a corpus (a collection of text documents) from the consumer complaint narrative
#install.packages("tm")
library(tm)
corpus <- Corpus(VectorSource(data$Consumer.complaint.narrative))

#clean the corpus:
corpus <- tm_map(corpus, tolower) #make everything lower case
corpus <- tm_map(corpus, removePunctuation) #remove punctuation
corpus <- tm_map(corpus, removeNumbers) #remove numbers
corpus <- tm_map(corpus, removeWords, stopwords('english')) #remove stop words

#install.packages("SnowballC")
library(SnowballC)
corpus <- tm_map(corpus, stemDocument, language = "english") #stem the words

#take a look at the first 2 documents in the corpus
inspect(corpus[1:2])

#create a document term matrix from the corpus
dtm <- DocumentTermMatrix(corpus)

#remove sparse terms
sparse = .75
dtm <- removeSparseTerms(dtm, sparse)

#convert the document term matrix into a data frame
dtm.m <- as.matrix(dtm)
dtm.df <- as.data.frame(dtm.m)
