import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl

mpl.style.use('default')
# N = 2
N = 13


def m1(t):
    return np.cos(2*np.pi*N*t)

def m2(t):
    return 2*N*np.sinc(2*N*t)

def m3(t):
    beta = 1
    Rb = 200
    return Rb*np.cos(np.pi*beta*Rb*t)/(1-np.square(2*beta*Rb*t))*np.sinc(Rb*t)

# fs = 1e2
fs = 1e4
# fc = 10
fc = 1e3
B = fc
t_car = np.arange(-0.5, 0.5, 1/fs)
carrier = 2*np.cos(2*np.pi*fc*t_car)
sig_t = np.array([])
sig_rx = np.array([])
h_filter = 2*B*np.sinc(2*B*t_car)
ft = np.random.choice([m1, m2, m3])

# Packet
# Sig_t
# Sig_f

fig, ax = plt.subplots(4, 1)
fig.tight_layout()

for j in range(30):
    mtx = ft(t_car)*carrier + 0.01*np.random.randn(int(fs))
    Ns = mtx.size
    # mtx = m_t*carrier

    sig_t = np.append(sig_t, mtx)
    mrx = np.convolve(mtx*carrier, h_filter, 'same')/Ns
    sig_rx = np.append(sig_rx, mrx)


    # plt.plot(sig_t)
    # plt.xlim([0, 29*fs])
    # with plt.xkcd():
    freq = np.linspace(-fs / 2, fs / 2, Ns)
    # testx = ft(t_car)
    sig_tx_f = np.fft.fftshift(np.abs(np.fft.fft(mtx)) / Ns)
    sig_rx_f = np.fft.fftshift(np.abs(np.fft.fft(mrx)) / Ns)
    # fig.clear()
    ax[0].clear()
    ax[1].clear()
    ax[2].clear()
    ax[3].clear()
    ax[2].plot(freq, sig_tx_f, color='#5eb2db')
    ax[2].set_title("Freq Response of Tranmitted Pulse(Modulated)")
    # ax[2].
    ax[0].plot(t_car, mtx, color='#5eb2db')
    ax[0].set_title("Tranmitted Pulse(Modulated)")
    ax[1].plot(t_car, mrx, color='#5eb2db')
    ax[1].set_title("Received Pulse(Demodulated)")
    # ax[1].set_xlim([0, 5*fs])
    ax[3].plot(freq, sig_rx_f, color='#5eb2db')
    ax[3].set_title("Freq Response of Received Pulse")
    plt.pause(0.5)

# fig.savefig("Task1.png")
