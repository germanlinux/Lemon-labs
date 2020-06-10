# ### stanford ng andrew ex2



import numpy as  np
import pandas as pd
import matplotlib.pyplot as plt
from math import exp


def sigmoid(z):
		g = 1/(1 + np.exp(-1 * z))
		return g
		
def costFunction(theta, X , y):
	 m  = len(y)
	 _X = X.to_numpy()
	 _y = y.to_numpy()
	 _y = _y.reshape(-1,1)
	 _Xprime = _X.transpose() 
	 grad = np.array(theta.shape)
	 # calcul sigmoid
	 part1 = sigmoid(_X @ theta) 
	 _t1 =  _y * np.log(part1)
	 _t2 =  (1 - _y) * np.log(1 - part1)
	 J = (-1 / m ) * np.sum(_t1 + _t2)   
	 temp = sigmoid(_X @ theta)
	 error = temp - _y
	 grad = (1/m)  * (_Xprime @ error)
	 return(J, grad)

def gradient (theta, X , y):
 	m  = len(y)
 	_X      = X.to_numpy()
 	_y      = y.to_numpy()
 	_y      = _y.reshape(-1,1)
 	_Xprime = _X.transpose() 
 	grad    = np.array(theta.shape)
 	temp = sigmoid(_X @ theta)
 	error = temp - _y
 	grad = (1/m)  * (_Xprime @ error)
 	return grad
	
#  programme principal

#load data

data = pd.read_csv('ex2data1.txt', header=None,sep =',', names= ['x1','x2','y'])
for i in range(10):
    print(data['x1'].loc[i], data['x2'].loc[i], data['y'].loc[i])
print('graphisme des points avec une differentiation sur la valeur de y')
# extraction delective des points
recus   = data.loc[data['y']==  1]
recales = data.loc[data['y']==  0]
plt.rcParams['toolbar'] = 'None'

plt.figure()
plt.scatter(recus['x1'] , recus['x2'], c='black', marker ='+')
plt.scatter(recales['x1'] , recales['x2'], c='y', marker ='o')
plt.xlabel("Exam 1 score")
plt.ylabel("Exam 2 score")
plt.legend(["recus","recales"])
plt.show()

# test sigmoid
print(sigmoid(4))
t = np.array([1, 2 ,3])
print(sigmoid(t))
d = pd.DataFrame([1, 2 ,3])
print(sigmoid(d))
# preparaton des donnees
matrixX = data[['x1','x2']]
X =matrixX.copy()
X.insert(0,'x0',1)
initial_theta = np.zeros((X.shape[1],1))
cost,grad = costFunction(initial_theta, X, data['y'])
print(f"cost :{cost}")
print(f"gradient :{grad}")
test_theta= np.array([-24, 0.2, 0.2])
test_theta = np.reshape(test_theta,(X.shape[1],1))
cost,grad = costFunction(test_theta, X, data['y'])
print(f"cost :{cost}")
print(f"gradient :{grad}")


