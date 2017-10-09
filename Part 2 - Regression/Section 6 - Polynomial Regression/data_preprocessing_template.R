# Data Preprocessing Template

# Importing the dataset
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]#ignore the first column
# DONT DO THIS TIME - we have only 10 data points Splitting the dataset into the Training set and Test set
# install.packages('caTools')
#library(caTools)
#set.seed(123)
#split = sample.split(dataset$DependentVariable, SplitRatio = 0.8)
#training_set = subset(dataset, split == TRUE)
#test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

#fit linear regression to the dataset
lin_reg = lm(formula = Salary ~ .,data = dataset) #use the full dataset

#fit polynomial regression model to the dataset
dataset$Level2 = dataset$Level^2 # create new column Level2 which is the level column
dataset$Level3 = dataset$Level^3
dataset$Level4 = dataset$Level^4
poly_reg = lm(formula =Salary ~ .,data = dataset)

# visualise the linear regression results
library(ggplot2)
ggplot()+
  geom_point(aes(x=dataset$Level,y=dataset$Salary),
             colour = 'red')+  #scatter plot
  geom_line(aes(x=dataset$Level,y=predict(lin_reg,newdata=dataset)),colour = 'blue')+  #prediction plot on blue straight line
  ggtitle('Truth or bluff')+
  xlab('Level')+
  ylab('Salary')


#visualise polynomial results
library(ggplot2)
ggplot()+
  geom_point(aes(x=dataset$Level,y=dataset$Salary),
             colour = 'red')+  #scatter plot
  geom_line(aes(x=dataset$Level,y=predict(poly_reg,newdata=dataset)),colour = 'blue')+  #prediction plot on blue straight line
  ggtitle('Truth or bluff')+
  xlab('Level')+
  ylab('Salary')
#MUCH BETTER!!!!!...and if you add a fourth degree, the line fit is even better

#predict single predictions linear
y_pred = predict(lin_reg,newdata = data.frame(Level=6.5)) #this creates a new dataset with one specific value, instead of the whole dataset

#predict single predictions polynomial
y_pred = predict(poly_reg,newdata = data.frame(Level=6.5,Level2=6.5^2,Level3=6.5^3,Level4=6.5^4)) #this creates a new dataset with one specific value
#158862.5 





















