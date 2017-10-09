#https://www.superdatascience.com/machine-learning/

# index starts at 1
dataset = read.csv('Data.csv')
#select a subset of the dataset
#dataset = dataset[,2:3]

#process missing data
#replace with mean of column values




#split into training and test set
#install.packages('caTools')
#this selects the library for usage
library(caTools)
set.seed(123)
#set random seed
split = sample.split(dataset$Purchased,SplitRatio = 0.8)
training_set = subset(dataset,split==TRUE)
test_set = subset(dataset,split==FALSE)
#bingo - we have split the 10 points into 8 training and 2 test points

#now for scaling - only scale columns 2,3 - 1,4 are factor columns (country, purchased) and not numeric
#training_set[,2:3] = scale(training_set[,2:3])
#test_set[,2:3] = scale(test_set[,2:3])

