import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl
from scipy.io import wavfile

mpl.style.use('default')

class Signal:

    def __init__(self, t, y):
        self.t = t
        self.y = y

    @property
    def fs(self):
        return int(1/(t[1]-t[0]))

    @property
    def Ns(self):
        return self.y.size

    def get_fft(self):
        self.freq = np.fft.fftfreq(self.Ns, 1/self.fs)
        self.mag = np.abs(np.fft.fft(self.y))

        return (self.freq, self.mag)

    def get_points(self):
        return self.t, self.y

    def append(self, x):
        if type(x) == Signal:
            x = x.y

        self.y = np.append(self.y, x)
        self.t = np.arange(self.t[0], self.Ns/self.fs, 1/self.fs)
        self.get_fft()

        return self.y

    def __add__(self, other):
        self.y = self.y + (other.y if type(other) == Signal else other)
        return self

    def __sub__(self, other):
        self.y = self.y - (other.y if type(other) == Signal else other)
        return self

    def __mul__(self, other):
        self.y = self.y * (other.y if type(other) == Signal else other)
        return self


fs =
N =

# (afs, audio) = wavfile.read('sample_a.wav')
# aud_sample = audio[:, 0]
