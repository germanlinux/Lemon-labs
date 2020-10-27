import numpy as  np
import pandas as pd
import matplotlib.pyplot as plt
#from math import exp
from scipy.optimize import fmin_tnc
from sklearn.metrics import confusion_matrix

#https://github.com/Benlau93/Machine-Learning-by-Andrew-Ng-in-Python/blob/master/LogisticRegression/ML_LogisticRegression.ipynb
def predictions(theta , X):
    prev = []
    for lig in X:
        res = sigmoid(np.transpose(theta) @ np.transpose(lig))
        if res >= 0.5 :
            prev.append(1)
        else:
            prev.append(0)
    return prev

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

def f_cost(theta, X, y):
    m=len(y)
    predictions = sigmoid(np.dot(X,theta))
    error = (-y * np.log(predictions)) - ((1-y)*np.log(1-predictions))
    cost = 1/m * sum(error)
    return cost


def featureNormalization(X):
    """
    Take in numpy array of X values and return normalize X values,
    the mean and standard deviation of each feature
    """
    mean=np.mean(X,axis=0)
    std=np.std(X,axis=0)
    X_norm = (X - mean)/std
    return X_norm , mean , std

def f_gradient(theta, X, y):
     predictions = sigmoid(np.dot(X,theta))
     grad = 1/m * np.dot(X.transpose(),(predictions - y))    
     return grad

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
y  = data['y'].to_numpy()
#X.insert(0,'x0',1)
#Xtranspo = np.vstack((np.ones(M), X)).T
X = X.to_numpy()
m  = X.shape[0]
X, X_mean, X_std = featureNormalization(X)
X = np.c_[ np.ones(m), X]
n = X.shape[1]
theta_0 = np.zeros((n,1))
#  pandes style  X= np.append(np.ones((m,1)),X,axis=1)
y=y.reshape(m,1)
initial_theta = theta_0
cost, grad= costFunction(initial_theta,X,y)
print("Cost of initial theta is",cost)
print("Gradient at initial theta (zeros):",grad)
theta , J_history = gradientDescent(X,y,initial_theta,1,400)
print("Theta optimized by gradient descent:",theta)
print("The cost of the optimized theta:",J_history[-1])
x_test = np.array([45,85])
x_test = (x_test - X_mean)/X_std
x_test = np.append(np.ones(1),x_test)
prob = sigmoid(x_test.dot(theta))
print("For a student with scores 45 and 85, we predict an admission probability of",prob[0])
print("methode unitaire")
cout =  f_cost(initial_theta,X,y)
gradient = f_gradient(initial_theta,X,y)
print("cost",cout)
print("gradient", gradient)
essai = fmin_tnc(func = f_cost, x0 = initial_theta.flatten(), fprime = f_gradient , args = (X , y.flatten() )          )
print('theta fmin', essai[0])    
prob = sigmoid(x_test.dot(essai[0]))
print(prob)
prev = predictions(theta, X)
cible = y.flatten()
confusion = confusion_matrix(prev,cible,[0,1])
print('matrice de confusion',confusion)

total  = np.sum(confusion)

prec = (confusion[0][0] + confusion[1][1]) / total
effic = confusion[1][1]/np.sum(confusion, axis = 0)[1]  
print('precision',prec)
print('pertinence', effic)