#!/usr/bin/env python
# coding: utf-8

# ### stanford ng andrew ex1



import numpy as  np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import cm
from mpl_toolkits.mplot3d import Axes3D  
def computeCost(X, y, theta ):
    m = len(y)
    tempj = 0
    for i in range(m):  #  0 to m-1
         tempj += (X.loc[i]@theta  - y.loc[i])**2
    j = 1/(2 * m) * tempj
    return(j)

def  gradientDescent(X, y, theta, alpha, num_iters):
     m = len(y)
     j_history = np.zeros((num_iters, 1))
     Xtrans = np.transpose(X)
     for i in range(num_iters):
        wmat = X @ theta
        wmat = wmat[0].sub(y['y'])
        gradients = 1/m * (Xtrans @ wmat)   
        gradientsb = np.reshape(gradients.to_numpy(),(2,1))
        theta = theta - alpha * gradientsb
        z = computeCost(X,y,theta) 
        j_history[i] = z['y']   
     return(theta)   
#  
#  programme principal

a = np.eye(5) 
print(a)
plt.ion()
plt.figure()

data = pd.read_csv('ex1data1.txt', header=None,sep =',', names= ['x','y'])

# afficher les points

plt.scatter(data['x'], data['y'], c='red', marker ='x')
plt.xlabel("Population of city in 10,000s")
plt.ylabel("Profit in $10,000s")


plt.pause(5)
#plt.draw()
#plt.pause(0.001)
plt.show(block=False)
data.insert(0,'x0', 1)
data.rename(columns={ 'x':'x1' }, inplace =True)
matrixX = data[['x0','x1']]
X =matrixX.copy()
matrixy =data[['y']]
y = matrixy.copy()


theta = np.zeros((2, 1))

J = computeCost(X, y, theta)
print(J)
J = computeCost(X, y, [[-1] ,[ 2]])
print(J)


iterations = 1500
alpha = 0.01
theta = np.zeros((2, 1))
theta = gradientDescent(X, y, theta, alpha, iterations)
print('theta',theta)
print('estimation 35000: ',([1, 3.5] @ theta) * 10000)
print('estimation 70000: ',([1, 7] @ theta) * 10000)

# affiche la droite 
plt.plot(data['x1'], X @ theta)
plt.show(block=False)
plt.pause(5)
thetha_g0 = np.linspace(-10, 10, num = 100)
thetha_g1 = np.linspace(-1, 4, num = 100)
j_val = np.zeros((len(thetha_g0), len(thetha_g1)))
for i in range(len(thetha_g0)):
    for j in range(len(thetha_g1)):
        t = [[thetha_g0[i]], [thetha_g1[j]]]
        j_val[i][j] = computeCost(X, y, t)

j_valok = np.transpose(j_val)
t0,t1 = np.meshgrid(thetha_g0,thetha_g1)

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(t1, t0, j_valok,  cmap=cm.coolwarm,
                       linewidth=0)

# contour
fig3 = plt.figure()
tre= np.logspace(-2, 3, 20)
ax2 = fig3.add_subplot(111)
ax2.contour(t1, t0, j_valok, tre,   colors='black')
plt.plot(theta[1],theta[0], c='red', marker ='x' )
plt.show()
plt.pause(5)