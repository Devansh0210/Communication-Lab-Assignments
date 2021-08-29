import numpy as np
import matplotlib.pyplot as plt


# Power received
def Pr(f, d, Pt=1, Gt=10, Gr=0):
    """

    :param float f: frequency of transmission (Hz)
    :param float d: distance (m)
    :param float Pt: Power transmitted (W)
    :param float Gt: Antenna gain of Transmitter (dB)
    :param float Gr: Antenna Gain of Receiver (dB)
    :return: Power Received in dBm
    """
    Gt = np.exp(Gt / 10)
    Gr = np.exp(Gr / 10)
    l = 3.0e8 / f
    P = Pt * Gt * Gr * np.square(l) / np.square(4 * np.pi * d)
    return 10.0 * np.log10(P) + 30  # Power in dBm = 10log10(P/1mW)


f1 = 900e6
f2 = 2.4e9

d = np.arange(100, 5000, 500)

Pr_f1 = Pr(f1, d)
Pr_f2 = Pr(f2, d)

fig, ax = plt.subplots()
ax.plot(d, Pr_f1)
ax.plot(d, Pr_f2)

plt.show()