# index starts at 1
dataset = read.csv('Data.csv')

#process missing data
#replace with mean of column values

#fill in missing age values
dataset$Age = ifelse(is.na(dataset$Age),
            ave(dataset$Age,FUN = function(x) mean(x,na.rm=TRUE)),
            dataset$Age
                     )
dataset$Salary = ifelse(is.na(dataset$Salary),
                     ave(dataset$Salary,FUN = function(x) mean(x,na.rm=TRUE)),
                     dataset$Salary
)

#categorical variables are numeric represenations of text/bools

dataset$Country=factor(dataset$Country,
                       levels = c('France','Spain','Germany'),
                       labels = c(1,2,3)
                       )


dataset$Purchased=factor(dataset$Purchased,
                       levels = c('No','Yes'),
                       labels = c(0,1)
)


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
training_set[,2:3] = scale(training_set[,2:3])
test_set[,2:3] = scale(test_set[,2:3])

#instructions on setting up working directory
#https://www.udemy.com/machinelearning/learn/v4/t/lecture/7647088?start=0

#getwd()
#setwd('*****MachineLearning/Machine Learning A-Z Template Folder/Part 2 - Regression/Section 6 - Polynomial Regression/Polynomial_Regression')






