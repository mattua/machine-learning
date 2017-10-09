# Data Preprocessing Template

# Importing the dataset
dataset = read.csv('50_Startups.csv')


#need to catgorise the state values

# Encoding categorical data
dataset$State = factor(dataset$State,
                         levels = c('New York', 'California', 'Florida'),
                         labels = c(1, 2, 3))


# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

#regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State..........)# . replaces space in column headings
regressor = lm(formula = Profit ~ .,data = training_set) 

summary(regressor)

#notice that R has already created dummy variables for the state values BECAUSE we had previously encoded them
#it also removed one of the dummy variables State1 to remove redundancy

y_pred = predict(regressor,newdata=test_set)

#now lets do the backward elimination - assume significance level 5% ...when the max P is higher than this, remove it and repeat
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,data = training_set) 
summary(regressor)
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend,data = training_set) 
summary(regressor)
regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend,data = training_set) 
summary(regressor)
regressor = lm(formula = Profit ~ R.D.Spend,data = training_set) 
summary(regressor)




# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)