# -*- coding: utf-8 -*-
"""
Created on Thu Jun  8 21:30:24 2023

@author: alexi
"""

import scipy.optimize as sp
from scipy.integrate import quad
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

PI = 3.141592
B = 0.085E-3
H = 0.356E-3
L=500

def f(x,A,c,Lambda):
    beta = 2 * PI * B * np.sin((x-c)/L) / (2 * Lambda)
    gamma = 2 * PI * H * np.sin((x-c)/L) / (2 * Lambda)
    return A*(np.sin(beta)/beta)*(np.sin(beta)/beta)*np.cos(gamma)*np.cos(gamma)

def curvefit(xs,a,b,c):
    return [quad(f,0,x,args=(a,b,c))[0] for x in xs]

filename = 'Hydrogen.xlsx'
sheet_name = 'Sheet1'
mode = 'without_integral_3'

df = pd.read_excel(filename, sheet_name = sheet_name,skiprows = 0, nrows=787)
list_value = df.values.tolist()
x = []
y = []
yerr = []
x_fit = np.arange(1,8,0.01).tolist()
for i in list_value:
    x.append(i[1])
    y_val = (i[8] + i[9] + i[10])/3
    y.append(y_val)
    y_sd = (i[8]**2 + i[9]**2 + i[10]**2)/3 - y_val**2
    y_sd = np.sqrt(y_sd)
    yerr.append(y_sd)
    
initial_p0=[70, 5.35 , 5.00E-7]
minus_bounds_p0 = []
plus_bounds_p0 = []

for i in initial_p0:
    minus_bounds_p0.append(i - i * 0.9)
    plus_bounds_p0.append(i + i * 0.9)
bounds_p0 = [minus_bounds_p0, plus_bounds_p0]
parameter, covar = sp.curve_fit(f,x,y,p0 = initial_p0, bounds = bounds_p0)
parameter = parameter.tolist()
sigma_ab = np.sqrt(np.diagonal(covar))
sigma_ab.tolist()
xerr = []

for i in x:
    xerr.append(0.05)

plt.errorbar(x, y,xerr = xerr,yerr = yerr,label='data',marker = 's',color='k',linestyle='',capsize=2,markersize = 1.5)
y_fit = []
bound_upper = []
bound_lower = []
upper_parameter = []
lower_parameter = []
for i in range(len(parameter)):
    upper_parameter.append(parameter[i]+sigma_ab[i])
    lower_parameter.append(parameter[i]-sigma_ab[i])
    
for i in x:
    y_fit.append(f(i,parameter[0],parameter[1],parameter[2]))

y = np.array(y)
y_fit = np.array(y_fit)
residuals = y - y_fit
ss_res = np.sum(residuals**2)
ss_tot = np.sum((y-np.mean(y))**2)
r_squared = 1 - (ss_res / ss_tot)

y_fit = []

for i in x_fit:
    y_fit.append(f(i,parameter[0],parameter[1],parameter[2]))

for i in x_fit:
    upper = 0
    lower = 100
    upper = max(f(i,upper_parameter[0],upper_parameter[1],upper_parameter[2]),f(i,lower_parameter[0],lower_parameter[1],lower_parameter[2]))
    lower = min(f(i,upper_parameter[0],upper_parameter[1],upper_parameter[2]),f(i,lower_parameter[0],lower_parameter[1],lower_parameter[2]))
    bound_upper.append(upper)
    bound_lower.append(lower)

plt.plot(x_fit,y_fit,label='fit',linewidth = 0.6,linestyle='--',color='r')

# plotting the confidence intervals
plt.fill_between(x_fit, bound_lower, bound_upper,
                 color = 'black', alpha = 0.15,label='confidence range')

plt.legend(loc = 'upper left')
plt.rcParams["figure.dpi"] = 300
plt.xlabel('distance [mm]')
plt.ylabel('counts [a.u]')
plt.ylim([0, max(max(y),max(y_fit))*1.08])
r_squared = round(r_squared,5)
covar = np.sqrt(np.diag(covar)).tolist()
plt.text(6.5,max(max(y),max(y_fit)),'R^2 = '+str(r_squared))
plt.savefig(filename.split('.')[0]+sheet_name+mode,dpi = 300)

print(r_squared)
print(parameter)
print(covar)

f = open(filename.split('.')[0]+sheet_name+mode+".txt", 'w')
f.write(str(parameter)+'\n')
f.write(str(covar)+'\n')
f.write(str(r_squared))
f.close()