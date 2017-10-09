#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 25 18:00:56 2017

@author: mattua
"""

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

dataset = pd.read_csv('Data.csv')
print('Hello bob')

#create the matrix of independent variables
#all lines, all columns except the last one
X = dataset.iloc[:,:-1].values

#define the column of dependent variables
y=dataset.iloc[:,3]

#fill in missing values with mean of other values
from sklearn.preprocessing import Imputer
#define NAN as missing values, axis 0 means mean column values
imputer = Imputer(missing_values = 'NaN',strategy='mean',axis =0)
#upper bound is excluded
imputer = imputer.fit(X[:,1:3])

X[:,1:3] = imputer.transform(X[:,1:3])

#categorisation - countries as numbers
from sklearn.preprocessing import LabelEncoder,OneHotEncoder
labelencoder_X = LabelEncoder()
X[:,0] = labelencoder_X.fit_transform(X[:,0])
#lets comment this out since we want to use hot encoder instead


#use dummy encoding
#create column for each possible value
#which column index (0) we want to encode
onehotencoder = OneHotEncoder(categorical_features=[0])
X=onehotencoder.fit_transform(X).toarray()
#now we have a column for each enum value which is either
#0 or 1 if that value applies for that row
 
#now label encode the dependent variable PURCHASED
labelencoder_y = LabelEncoder()
y = labelencoder_y.fit_transform(y)

#split into training and test set
from sklearn.cross_validation import train_test_split
#0.25 means the % of data going into the test set
X_train,X_test,y_train,y_test = train_test_split(X,y,test_size=0.2,random_state=0)

#now for scaling...because different numeric columns are on different scales, different ranges
#euclidean distance will be dominated by the columns with higher numbers 
#can use standardisation or normalisation
from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test)
#dont fit, just transform for the test set - now all variables are scaled

#this is how we show our current working directory
import os
os.getcwd()

#this is how we change working directory
os.chdir('*****MachineLearning/Machine Learning A-Z Template Folder/Part 2 - Regression/Section 6 - Polynomial Regression/Polynomial_Regression')









