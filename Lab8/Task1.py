import numpy as np
from scipy.signal import hilbert
from matplotlib import pyplot as plt


beta_FM = 10
N = 13
beta_PM = 20

fc = 1e2
fm = N
B = 2*(beta_FM + 1)*fm
fs = 1e5
T_final = 0.1
mp = 2*N
kf = beta_FM*fm/mp
t = np.arange(0, 5/N, 1/fs)

m1 = 2*N*np.sin(2*N*np.pi*t)
m1_int = -1/np.pi*np.cos(2*N*np.pi*t)

m_tx_FM = 10*np.cos(2*np.pi*fc*t + kf*m1_int)
m_tx_PM = 10*np.cos(2*np.pi*fc*t + beta_PM/mp*m1)
fig1, ax1 = plt.subplots(2, 1)
ax1[0].plot(t, m1)
ax1[1].plot(t, m_tx_FM)
fig1.show()

fig2, ax2 = plt.subplots(2, 1)
ax2[0].plot(t, m1)
# ax2[0].set_xlabel("")
ax2[1].plot(t, m_tx_PM)
fig2.show()

fig3, ax3 = plt.subplots(1, 1)
freq = np.linspace(-fs/2, fs/2, t.size)
m_fft = np.abs(np.fft.fftshift(np.fft.fft(m_tx_FM)))

ax3.plot(freq, m_fft)
ax3.set_xlim([-1000, 1000])
fig3.show()
plt.show()