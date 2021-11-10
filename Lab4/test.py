import numpy as np
import matplotlib.pyplot as plt
import random
import math


def rect_pulse(freq, pulse_width):
    return np.where(abs(freq) <= pulse_width / 2, 1, 0)


last_digit_id = 3
f1 = random.randint(10, 100)
f2 = random.randint(10, 100)
time_endpt = 30
final_x = np.array([])
final_t = np.array([])

for T in range(time_endpt):
    # Defining all the common parameters for each second
    start_time = 0
    stop_time = 1
    fm = 100  # Maximum frequency component in Hertz for the given spectrum - Last digit of ID number goes here
    fs = 10 * fm
    ts = 1 / fs
    time = np.arange(start_time, stop_time, ts)
    final_t = np.append(final_t, time+T)

    # Frequency axis
    N = len(time)
    freq_axis = np.linspace(-fs / 2, fs / 2, N)

    # Modelling the channel
    B = 50
    channel_t = 2 * B * np.sinc(2 * B * (time - (start_time + stop_time) / 2))
    channel_f = rect_pulse(freq_axis, 2 * B)  # Done using a rectangular pulse
    # channel_f = np.fft.fftshift(np.abs(np.fft.fft(channel_t)/fs)) # Done using the fft of sinc pulse
    # Either of the two can be used, and they give identical results

    # Generating the message signal
    message_t = last_digit_id * np.cos(2 * math.pi * f1 * time) + last_digit_id * np.cos(2 * math.pi * f2 * time)
    message_f = np.fft.fftshift(np.abs(np.fft.fft(message_t) / fs))

    output_t = np.convolve(message_t, channel_t, mode='same') / fs
    output_f = np.fft.fftshift(np.abs(np.fft.fft(output_t) / fs))
    final_x = np.append(final_x, output_t)
    # plt.figure(1)
    # plt.plot(time + T, output_t)
    # plt.title('Time Domain')
    # plt.xlabel('Time')
    # plt.ylabel('Amplitude')
    # # plt.show()
    #
    #
    # plt.figure(2)
    # plt.plot(freq_axis, output_f)
    # plt.title('Frequency Domain')
    # plt.xlabel('Frequency')
    # plt.ylabel('Amplitude')

    # plt.pause(1)
plt.plot(final_t, final_x)
plt.show()