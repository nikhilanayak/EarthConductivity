using FFTW

using PyPlot

A =   [200, 90, 30, 17, 8, 3.5, 1]
Phi = [10, 20, 30, 40, 50, 60, 70]

f = [0.00009259, 0.00020833, 0.00047619, 0.00111111, 0.00238095, 0.00555555, 0.025]

function SMFV(x)
	y = 0
	for i in 1:7
		y += A[i] * sin(
				2 * pi * f[i] * x 
				+ (pi / 180 * Phi[i])
			    )
	end

	return y
end


timestep = 1000

X = 0:timestep:86400
Y = SMFV.(X)

f = fft(Y)
freq = fftfreq(length(Y), timestep)

plot(freq, abs.(f))

