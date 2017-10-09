# Data Preprocessing Template


#multiple linear regression - there are simply more independent variables

#y = c + b1x1 + b2X2 + b3x3 etc
# need to create dummy variables for categorical variables - New York, California
# so if that category applies, that value is zero
# dummy variable trap - dont include both dummy variables in the model equation
# this is because there is a relationship between the dummy variables
# called multi colinearity

#backward eliminations
#1 pick significance level to stay in the model (eg SL=0.05)
#2 fit full model with all predictors
#3 consider the predictor with the highest p-value, if P>Sl go to 4) otherwise go to FIN
#4 remove the predictor
#5 fit model without this variable.

#forward selection




# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Importing the dataset
dataset = pd.read_csv('50_Startups.csv')
X = dataset.iloc[:, :-1].values
y = dataset.iloc[:, 4].values

#need to create dummy variables to encode the state
# Encoding categorical data
# Encoding the Independent Variable
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelencoder_X = LabelEncoder()
#3rd column is the state
X[:, 3] = labelencoder_X.fit_transform(X[:, 3])
onehotencoder = OneHotEncoder(categorical_features = [3])
X = onehotencoder.fit_transform(X).toarray()
#each state value is now represented as one column

#avoiding the dummy variable trap
X=X[:,1:]# remove the first column, take all rows and column 1 to the end


# Splitting the dataset into the Training set and Test set
from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)


# Feature Scaling
"""from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test)
sc_y = StandardScaler()
y_train = sc_y.fit_transform(y_train)"""


#fitting multilinear model to training set
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train,y_train)

#test the performance
y_pred = regressor.predict(X_test)

#this is probably not the optimal model - maybe not all these are significant
#find team of independent variable that has biggest impact
#backward elimination
import statsmodels.formula.api as sm
#stats model doesnt take into account the constant, so
#we need to add a column of 1's - so we will get the value of the
#constant
X = np.append(arr=np.ones((50,1)).astype(int),values =X ,axis=1)

#create optimum matrix of features
X_opt = X[:,[0,1,2,3,4,5]]

#select significance level to say in the model.
#SL = 0.05
#fit the full model with all predictors
#OLS is ordinary least squares
#endog is dependent variable
#exog is matrix of features
regressor_OLS = sm.OLS(endog=y,exog=X_opt).fit()
#need to see which factor has the highest p value
regressor_OLS.summary()

#highest P value is 0.99 which is x2 dummy variable - at index 2
#so we omit that
X_opt = X[:,[0,1,3,4,5]]
regressor_OLS = sm.OLS(endog=y,exog=X_opt).fit()
regressor_OLS.summary()
#again x1 is the highest P value...index 1
X_opt = X[:,[0,3,4,5]]
regressor_OLS = sm.OLS(endog=y,exog=X_opt).fit()
regressor_OLS.summary()

#now x1 is the highest P ...0.647
X_opt = X[:,[0,3,5]]
regressor_OLS = sm.OLS(endog=y,exog=X_opt).fit()
regressor_OLS.summary()

#this still has the highest P value above 5%...it's actually 6%, so to be strict we remove it
#
X_opt = X[:,[0,3]]
regressor_OLS = sm.OLS(endog=y,exog=X_opt).fit()
regressor_OLS.summary()


#now all the variables have tiny P value...so we are done
#shows that only the R&D spend is actually significant (column 0 is the constant)










