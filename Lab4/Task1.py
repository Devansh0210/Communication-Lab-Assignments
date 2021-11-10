import numpy as np
import matplotlib.pyplot as plt
from numpy.fft import fft
import random
import time


start_time = 0
stop_time = 1
fm = 10  # Maximum frequency component in Hertz for the given spectrum
fs = 10 * fm
ts = 1 / fs
mx = np.array([])
tvect = np.array([])


for T in range(30):
    time = np.arange(start_time+T, stop_time+T, ts)
    U = random.randint(1,5)
    m_t = U*np.cos(2*fm*time)
    mx = np.append(mx, m_t)
    tvect = np.append(tvect, time)
    mf = fft(mx)/fs
    N = len(mf)
    mf_abs_sorted = np.fft.fftshift(abs(mf))
    freq_axis = np.linspace(-fs/2, fs/2, N)

    # Time Domain
    plt.figure(1)
    plt.plot(tvect, mx)
    plt.title(f'Time Domain, Time=({start_time+T}, {stop_time+T})')
    plt.xlabel('time')
    plt.ylabel('Amplitude')

    # Save the final figure
    if T==29:
        plt.savefig('task1_final_time.svg')

    # Frequency Domain
    plt.figure(2)
    plt.plot(freq_axis, mf_abs_sorted)
    plt.xlabel('Frequency(Hz)')
    plt.ylabel('Amplitude')
    plt.title(f'Frequency Domain, Time=({start_time+T}, {stop_time+T})')

    # Save the final figure
    if T==29:
        plt.savefig('task1_final_fft.svg')

    plt.show()
    plt.pause(0.5)