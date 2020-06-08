# ### stanford ng andrew ex2



import numpy as  np
import pandas as pd
import matplotlib.pyplot as plt


#  programme principal

#load data

data = pd.read_csv('ex2data1.txt', header=None,sep =',', names= ['x1','x2','y'])
for i in range(10):
    print(data['x1'].loc[i], data['x2'].loc[i], data['y'].loc[i])
print('graphisme des points avec une differentiation sur la valeur de y')
# extrqction delective des points
