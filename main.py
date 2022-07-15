import numpy as np
import matplotlib.pyplot as plt

A =   [200, 90, 30, 17, 8, 3.5, 1]
Phi = [10, 20, 30, 40, 50, 60, 70]

f = [0.00009259, 0.00020833, 0.00047619, 0.00111111, 0.00238095, 0.00555555, 0.025]


def SMFV(x):
    y = 0
    for i in range(7):
        y += A[i] * np.sin(
            2 * np.pi * f[i] * x +
            (np.pi / 180 * Phi[i])
        )
    return y


def K(f):
    mu = 4 * np.pi * 10e-7
    sigma = 1000
    i = 1j
    #return np.sqrt((1j * 2 * np.pi * x) / (4 * np.pi  * 10e-7 * 1000))
    return np.sqrt(
        (i * 2 * np.pi * f) / 
        (mu * sigma)
    )




X = np.linspace(0, 8640, 86400)
Y = [SMFV(i) for i in X]

#plt.plot(X, Y)
#plt.show()


sp = np.fft.fft(Y)
freq = np.fft.fftfreq(X.shape[-1])

#plt.plot(freq, sp.real, freq, sp.imag)
plt.plot(freq, np.abs(sp))

#for i in range(7):
#    plt.axvline(x=f[i], color="green", alpha=0.5)


plt.show()

