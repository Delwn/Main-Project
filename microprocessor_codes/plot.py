import pandas as pd
from matplotlib import pyplot as plt
import numpy as np
from scipy.stats import mode
import statistics as sp

from google.colab import drive
drive.mount('/content/drive')

dataset=pd.read_csv("/content/drive/MyDrive/project files/data.csv")
print(dataset)
arr1 = np.array(dataset['x'])
arr2 = np.array(dataset['y'])
arr3 = np.array(dataset['z'])

avg1=np.average(arr1)
avg2=np.average(arr2)
avg3=np.average(arr3)
print(avg1,"\n",avg2,"\n",avg3,"\n")
plt.plot(dataset['x'], color="red", label='X')
plt.plot(dataset['y'], color="blue", label='Y')
plt.plot(dataset['z'], color="green", label='Z')
plt.axhline(avg1,linestyle="dotted",color='red')
plt.axhline(avg2,linestyle="dotted",color='blue')
plt.axhline(avg3,linestyle="dotted", color='green')
plt.scatter(0,avg1, color="red", marker='o', label=f'Avg: {avg1:.2f}')
plt.scatter(0,avg2, color="blue", marker='o', label=f'Avg: {avg2:.2f}')
plt.scatter(0,avg3, color="green", marker='o', label=f'Avg: {avg3:.2f}')

plt.legend()
plt.show()