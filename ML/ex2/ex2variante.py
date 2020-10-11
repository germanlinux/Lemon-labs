import numpy as  np
import pandas as pd
import matplotlib.pyplot as plt
#from math import exp
from scipy.optimize import fmin_tnc
from sklearn.metrics import confusion_matrix

#https://github.com/Benlau93/Machine-Learning-by-Andrew-Ng-in-Python/blob/master/LogisticRegression/ML_LogisticRegression.ipynb
def sigmoid(z):
        g = 1/(1 + np.exp(-1 * z))
        return g

def costFunction(theta, X, y): 
    m=len(y)
    predictions = sigmoid(np.dot(X,theta))
    error = (-y * np.log(predictions)) - ((1-y)*np.log(1-predictions))
    cost = 1/m * sum(error)
    grad = 1/m * np.dot(X.transpose(),(predictions - y))
    return cost[0] , grad

def featureNormalization(X):
    """
    Take in numpy array of X values and return normalize X values,
    the mean and standard deviation of each feature
    """
    mean=np.mean(X,axis=0)
    std=np.std(X,axis=0)
    X_norm = (X - mean)/std
    return X_norm , mean , std

def gradientDescent(X,y,theta,alpha,num_iters):   
    m=len(y)
    J_history =[]
    for i in range(num_iters):
        cost, grad = costFunction(theta,X,y)
        theta = theta - (alpha * grad)
        J_history.append(cost)
    
    return theta , J_history

#load data

data = pd.read_csv('ex2data1.txt', header=None,sep =',', names= ['x1','x2','y'])
recus   = data.loc[data['y']==  1]
recales = data.loc[data['y']==  0]


print(sigmoid(4))
t = np.array([1, 2 ,3])
print(sigmoid(t))
d = pd.DataFrame([1, 2 ,3])
print(sigmoid(d))
# preparaton des donnees
X = data[['x1','x2']]
X.insert(0,'x0',1)
#Xtranspo = np.vstack((np.ones(M), X)).T
X = X.to_numpy()

theta_0 = np.zeros(3)
m , n = X.shape[0], X.shape[1]
X, X_mean, X_std = featureNormalization(X)
X= np.append(np.ones((m,1)),X,axis=1)
y=y.reshape(m,1)
initial_theta = np.zeros((n+1,1))
cost, grad= costFunction(initial_theta,X,y)
print("Cost of initial theta is",cost)
print("Gradient at initial theta (zeros):",grad)
theta , J_history = gradientDescent(X,y,initial_theta,1,400)