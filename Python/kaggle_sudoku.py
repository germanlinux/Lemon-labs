import numpy as np
import pandas as pd
import keras
import keras.backend as K
from keras.optimizers import Adam
from keras.models import Sequential
from keras.utils import Sequence
from keras.layers import *
import matplotlib.pyplot as plt
path = "../input/sudoku/"
data = pd.read_csv(path+"sudoku.csv")
try:
    data = pd.DataFrame({"quizzes":data["puzzle"],"solutions":data["solution"]})
except:
    pass
data.head()
data.info()
print("Quiz:\n",np.array(list(map(int,list(data['quizzes'][0])))).reshape(9,9))
print("Solution:\n",np.array(list(map(int,list(data['solutions'][0])))).reshape(9,9))

#Utility Functions
class DataGenerator(Sequence):
    def __init__(self, df,batch_size = 16,subset = "train",shuffle = False, info={}):
        super().__init__()
        self.df = df
        self.batch_size = batch_size
        self.shuffle = shuffle
        self.subset = subset
        self.info = info
        
        self.data_path = path
        self.on_epoch_end()
        
    def __len__(self):
        return int(np.floor(len(self.df)/self.batch_size))
    def on_epoch_end(self):
        self.indexes = np.arange(len(self.df))
        if self.shuffle==True:
            np.random.shuffle(self.indexes)
            
    def __getitem__(self,index):
        X = np.empty((self.batch_size, 9,9,1))
        y = np.empty((self.batch_size,81,1))
        indexes = self.indexes[index*self.batch_size:(index+1)*self.batch_size]
        for i,f in enumerate(self.df['quizzes'].iloc[indexes]):
            self.info[index*self.batch_size+i]=f
            X[i,] = (np.array(list(map(int,list(f)))).reshape((9,9,1))/9)-0.5
        if self.subset == 'train': 
            for i,f in enumerate(self.df['solutions'].iloc[indexes]):
                self.info[index*self.batch_size+i]=f
                y[i,] = np.array(list(map(int,list(f)))).reshape((81,1)) - 1
        if self.subset == 'train': return X, y
        else: return X