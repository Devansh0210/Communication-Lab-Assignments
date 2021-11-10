import numpy as np
from scipy.signal import hilbert
from matplotlib import pyplot as plt
import scipy.integrate as integrate


beta = 20
fc = 100
fm = 10
BW = fc + 2*(beta+1)*fm
fs = 10*BW
t = np.arange(-0.5, 0.5, 1/fs)
t1 = np.arange(-10, 10, 1/fs)
A = 10
h_t = 0.1
sigma = 0.1
T_final = 10

fig, ax = plt.subplots(3, 1)

for k in range(T_final):
    U = np.random.randint(1, 10)
    m_t = 2*U*np.sinc(2*U*t1)
    m_t_int = np.cumsum(m_t)*1/fs

    mp = 2*U
    fm = U
    kf = beta*fm/mp

    m_tx = A*np.cos(2*np.pi*fc*t + 2*np.pi*kf*m_t_int[int(9.5*fs):int(10.5*fs)])*h_t + 0.001*np.random.randn(t.size)
    m_diff = np.diff(m_tx)
    m_demod = np.abs(hilbert(m_diff))

    # print(t.size)
    m_t = 2*U*np.sinc(2*U*t)
    ax[0].plot(t, m_t)
    ax[1].plot(t, m_tx)
    ax[2].plot(m_demod[0:t.size])


    fig.show()
    plt.pause(2)

plt.show()