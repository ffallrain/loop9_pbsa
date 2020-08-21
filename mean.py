#!/bin/python3

import numpy as np

I_sc_50 = np.loadtxt('I_sc_50')
mean = I_sc_50.mean()
std = I_sc_50.std()
print(mean,std) 


