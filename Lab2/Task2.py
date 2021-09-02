import math
import matplotlib.pyplot as plt

# Function for Power received
def Pr(f, d, Pt=1, Gt=10, Gr=0):
    """

    :param float f: frequency of transmission (Hz)
    :param float d: distance (m)
    :param float Pt: Power transmitted (W)
    :param float Gt: Antenna gain of Transmitter (dB)
    :param float Gr: Antenna Gain of Receiver (dB)
    :return: Power Received in dBm
    """
    Gt = 10**(Gt / 10)
    Gr = 10**(Gr / 10)
    l = 3.0e8 / f
    P = Pt * Gt * Gr * l**2 / (4 * math.pi * d)**2
    return 10.0 * math.log10(P) + 30 # Power in dBm = 10log10(P/1mW)


# First freq
f1 = 900e6

# Second Freq
f2 = 2.4e9

# distance
d = []

# Power received for freq f1
Pr_f1 = []

# Power received for freq f2
Pr_f2 = []

# Loop for calculating power at different distance from 100m to 5000m with step of 500m
for i in range(100, 5001, 500):
    d.append(i)
    Pr_f1.append(Pr(f1, i))
    Pr_f2.append(Pr(f2, i))

# Plotting the Power vs Distance
fig, ax = plt.subplots()
ax.plot(d, Pr_f1)
ax.plot(d, Pr_f2)

plt.show()