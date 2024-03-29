#程序文件ex3_4.py
import numpy as np
from scipy.sparse.linalg import eigs
import pylab as plt

L=[(1,2),(2,3),(2,4),(3,4),(3,5),
   (3,6),(4,1),(5,6),(6,1)]
w = np.zeros((6,6))
for i in range(len(L)):
    w[L[i][0]-1,L[i][1]-1]=1
r=np.sum(w,axis=1,keepdims=True)
P = (1-0.85)/w.shape[0]+0.85*w/np.tile(r,(1,w.shape[1]))
val, vec = eigs(P.T, 1); V = vec.real
V=V.flatten(); #展开成（n,)形式的数组
V=V/V.sum(); print("V=", np.round(V,4))
plt.bar(range(1,len(w)+1),V, width=0.6, color='b')
plt.show()
