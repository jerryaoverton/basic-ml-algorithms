# take a random sample of the data without sample replacement

#read the population data
data <- read.csv("consumer_complaints.csv")

#define the population size
population_size = nrow(data)

#define the percentage of the population to sample
sample_percent = .05

#take the sample
sample_size = as.integer(sample_percent * population_size)
data.sample <- data[sample(1:population_size, sample_size,replace=FALSE),]

write.csv(data.sample, file= "consumer_complaints_sample.csv")
