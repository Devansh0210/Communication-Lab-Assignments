import numpy as np
import matplotlib.pyplot as plt
from numpy.fft import fft
import random
import time
from scipy.io import wavfile

start_time = 0
stop_time = 1
N = 8  # Maximum frequency component in Hertz for the given spectrum
fs = 1000
ts = 1 / fs
mx = np.array([])
tvect = np.array([])
PI = np.pi
T_total = 5
tfil = np.arange(-0.5, 0.5, ts)
B = 50
h = 2*B*np.sinc(2*B*(tfil))

for T in range(T_total):
    time = np.arange(start_time, stop_time, 1/fs)
    f1 = np.random.randint(10, 100)
    f2 = np.random.randint(10, 100)
    m1 = N*(np.cos(2*PI*f1*time) + np.cos(2*PI*f2*time))
    m_t = np.convolve(m1, h, 'same')/fs
    mx = np.append(mx, m_t)
    tvect = np.append(tvect, time+T)
    mf = fft(mx)/fs
    N = len(mf)
    mf_abs_sorted = np.fft.fftshift(abs(mf))
    freq_axis = np.linspace(-fs/2, fs/2, N)
    plt.figure(1)
    plt.plot(time, m_t)
    # Time Domain
    plt.figure(1)
    plt.plot(tvect, mx)
    plt.title(f'Time Domain, Time=({start_time+T}, {stop_time+T})')
    plt.xlabel('time')
    plt.ylabel('Amplitude')

    # Save the final figure
    if T==T_total-1:
        plt.savefig('task2_final_time.svg')

    # Frequency Domain
    plt.figure(2)
    plt.plot(freq_axis, mf_abs_sorted)
    plt.xlabel('Frequency(Hz)')
    plt.ylabel('Amplitude')
    plt.title(f'Frequency Domain, Time=({start_time+T}, {stop_time+T})')

    # Save the final figure
    if T==T_total-1:
        plt.savefig('task2_final_fft.svg')

    plt.show()
    plt.pause(0.5)