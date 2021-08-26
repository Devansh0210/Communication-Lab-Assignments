import numpy as np
import matplotlib.pyplot as plt

N = 8

t = np.arange(0, 0.2, 1e-4)
y = np.sin(2*np.pi*10*N*t)

plt.xlabel("Time(s)")
plt.ylabel("Amplitude")
plt.plot(t, y)
# plt.savefig('sine_plot.jpeg')
plt.show()