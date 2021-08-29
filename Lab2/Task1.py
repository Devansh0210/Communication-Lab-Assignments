import numpy as np
from matplotlib import pyplot as plt

N = 8
PI = np.pi
B = N + 5

def sinc(x):
    return np.sin(x)/x

t = np.arange(-0.5, 0.5, 1e-4)

m = 2*B*sinc(2*PI*B*t)

fig, ax = plt.subplots()
ax.plot(t, m)
ax.grid(True, which='both')

ax.axhline(y=0, color='k')
ax.axvline(x=0, color='k')
plt.savefig('Task1_sinc.jpeg')
plt.show()
