#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 25 18:00:56 2017
THIS IS THE BASIC TEMPLATE FOR EVERY EXERCISE
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
y=dataset.iloc[:,3].values


#split into training and test set
from sklearn.cross_validation import train_test_split
#0.25 means the % of data going into the test set
X_train,X_test,y_train,y_test = train_test_split(X,y,test_size=0.2,random_state=0)

#now for scaling...because different numeric columns are on different scales, different ranges
#euclidean distance will be dominated by the columns with higher numbers 
#can use standardisation or normalisation
"""
from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test)
"""





