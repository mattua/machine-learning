# Data Preprocessing Template

# Importing the dataset
dataset = read.csv('Salary_Data.csv')

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

#4.27 preprocessing
#4.28 ~ means proportional to 
regressor = lm(formula = Salary ~ YearsExperience,
               data=training_set)

summary(regressor)#gives summary

'''
number of stars indicates significance of the variable.

If Pr < 5% then the variable is significant and has high impact on dependent variable

lm(formula = Salary ~ YearsExperience, data = training_set)

Residuals:
Min      1Q  Median      3Q     Max 
-7325.1 -3814.4   427.7  3559.7  8884.6 

Coefficients:
Estimate Std. Error t value Pr(>|t|)    
(Intercept)        25592       2646   9.672 1.49e-08 ***
YearsExperience     9365        421  22.245 1.52e-14 ***
---
'''
#4.29
#predict the test set results
y_pred = predict(regressor, newdata = test_set)

#4.30 plotting training set results
#install.packages('ggplot2')

#import into script
library(ggplot2)
ggplot()+
  #observation points of training set
  geom_point(aes(x=training_set$YearsExperience,y = training_set$Salary),
             color = 'red')+
  #scatter point of prediction of training set
  geom_point(aes(x=training_set$YearsExperience, y = predict(regressor, newdata = training_set)
),color = 'blue')+
  geom_line(aes(x=training_set$YearsExperience, y = predict(regressor, newdata = training_set)
  ),color = 'green')+
  ggtitle('Salary vs Experience (Training set)')+
  xlab('Years of exp')+
  ylab('Salary')

#now for the test set
ggplot()+
  #observation points of test set
  geom_point(aes(x=test_set$YearsExperience,y = test_set$Salary),
             color = 'red')+
  #regression line of prediction of training set/test set - doesnt matter, the line will be the same...the
  #regressor has already determined the gradient and intercept of the line
  geom_line(aes(x=training_set$YearsExperience, y = predict(regressor, newdata = training_set)
  ),color = 'green')+
  ggtitle('Salary vs Experience (test set)')+
  xlab('Years of exp')+
  ylab('Salary')

