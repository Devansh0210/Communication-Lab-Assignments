import numpy as np
import matplotlib.pyplot as plt
from numpy.fft import fft
import random
import time
from scipy.io import wavfile

start_time = 0
stop_time = 1
N = 8  # Maximum frequency component in Hertz for the given spectrum
fs = 10 * N
ts = 1 / fs
mx = np.array([])
tvect = np.array([])
PI = np.pi
T_total = 30

(afs, audio) = wavfile.read('sample_a.wav')
aud_sample = audio[:, 0]

aud_sample = 0.1*aud_sample[0:T_total*fs]

def m1(t):
    return np.cos(2*PI*N*t)

def m2(t):
    return 2*N*np.sinc(2*N*t)

def m3(t):
    return (np.abs(t)<1).astype(float)

def m4(t):
    start = int(t[0]*fs)
    stop = start + t.size
    return aud_sample[start:stop]

msgs = [m1, m2, m3, m4]



for T in range(T_total):
    time = np.arange(start_time+T, stop_time+T, 1/fs)
    func = np.random.choice(msgs)
    m_t = func(time)
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