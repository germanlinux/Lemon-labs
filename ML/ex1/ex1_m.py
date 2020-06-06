#!/usr/bin/env python
# coding: utf-8

# ### stanford ng andrew ex1



import numpy as  np
import pandas as pd
import matplotlib.pyplot as plt
def computeCost(X, y, theta ):
    m = len(y)
    tempj = 0
    for i in range(m):  #  0 to m-1
         tempj += (X.loc[i]@theta  - y.loc[i])**2
    j = 1/(2 * m) * tempj
    return(j)


def normalise(dataf):
    nbcol = dataf.shape[1]
    mu    = np.zeros(nbcol)
    sigma = np.zeros(nbcol)
    for i in range(nbcol):
        mu[i] = dataf.iloc[:,i].mean()
        sigma[i] = dataf.iloc[:,i].std( ddof=0)
    nom = dataf.columns    
    dftnorm = dataf[nom]
    for i,nm in enumerate(nom):
        nmx =nm + '_norm'   
        dftnorm[nmx] =(dftnorm[nm]- mu[i]) / sigma[i]

    return dftnorm , mu , sigma

def  gradientDescent(X, y, theta, alpha, num_iters):
     m = len(y)
     j_history = np.zeros((num_iters, 1))
     _X = X.to_numpy()
     _y = y.to_numpy()
     _y = _y.reshape(-1,1)

     _Xtrp = _X.transpose()
     for i in range(num_iters):
        wmat = (_X @ theta)
        _tmp = np.subtract(wmat,_y)
        gradients = 1/m * (_Xtrp @ _tmp)   
        theta = theta - alpha * gradients
        z = computeCost(X,y,theta) 
        j_history[i] = z  
     return theta, j_history      

def normalEqn(X,y):
    _X = X.to_numpy()
    _y = y.to_numpy()
    _theta = np.zeros((_X.shape[1], 1))
    _tmp = _X.transpose() 
    _theta = np.linalg.pinv(_tmp @ _X) @ _tmp @ _y
    return(_theta)



#  programme principal

#load data

data = pd.read_csv('ex1data2.txt', header=None,sep =',', names= ['x1','x2','y'])

# afficher les 10 premieres lignes

print(data[['x1','x2']][:10], data['y'][:10])
for i in range(10):
    print(data['x1'].loc[i], data['x2'].loc[i], data['y'].loc[i])

matrixX = data[['x1','x2']]
X =matrixX.copy()
okdata , mu, sig = normalise(X)
print(mu,sig)
#add 1 dans la 1ere colonne
okdata.insert(0,'x0',1)
iterations = 1400
alpha = 0.005
theta = np.zeros((3, 1))
theta, j_histo = gradientDescent(okdata[['x0','x1_norm','x2_norm']],data['y'],theta,alpha,iterations)
print("theta",theta)
plt.plot(range(len(j_histo)), j_histo)
plt.xlabel("Number of iterations")
plt.ylabel("Cost J")
plt.show(block=False)
plt.pause(10)
x1norm = (1650 - mu[0]) / sig[0]
X2norm = (3 -  mu[1]) / sig[1]
estimate= [1, x1norm, X2norm] @ theta
print("estimation pour 1650  et 3 chambres", estimate)
#1650  3  norm  puis 1, sq br * theta
X.insert(0,'x0',1)

thetaN = normalEqn(X[['x0','x1','x2']],data['y']) 
print(thetaN)
estimate = [1, 1650, 3] @ thetaN
print("estimation pour 1650  et 3 chambres methode normale", estimate)