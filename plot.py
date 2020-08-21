#!/usr/bin/env python
import matplotlib.pyplot as plt
import numpy as np

y = np.loadtxt("I_sc")
x = range( len(y) )


ypp = list()
for line in open("prodB_PP_full_energy.dat"):
    if "#" not in line:
        if len(line) > 10:
            ypp.append( float(line.split()[-1]) )

ypl = list()
for line in open("prodB_PL_full_energy.dat"):
    if "#" not in line:
        if len(line) > 10:
            ypl.append( float(line.split()[-1]) )

plt.plot(x,y)
plt.plot(x,ypp,label= 'CRBN-PDE6D')
plt.plot(x,ypl,label = 'Protein-TS2')
plt.legend()
plt.show()
