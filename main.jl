using FFTW
using PyPlot

# Constants from Table 1 (Parameters of synthetic magnetic field variation)
A =   [200, 90, 30, 17, 8, 3.5, 1]
Phi = [10, 20, 30, 40, 50, 60, 70]
f = [0.00009259, 0.00020833, 0.00047619, 0.00111111, 0.00238095, 0.00555555, 0.025]

function B(t) # Equation (20)
	y = 0
	for i in 1:7
		y += A[i] * sin(
				2 * pi * f[i] * t 
				+ (pi / 180 * Phi[i])
			    )
	end

	return y
end

function K(f) # Equation (13)
	mu = 4 * pi * 10e-7
	sigma = 1000
	i = 1im
	
	return sqrt(
		(i * 2 * pi * f) / 
		(mu * sigma)
	)
end


timestep = 0.1 # 0.1 second timestep

X = 0:timestep:86400 # 1 day, with a timestep from above
Y = B.(X) # Figure 6

freq = fftfreq(length(Y), timestep)

conv = K.(freq) .* fft(Y)

inverse = ifft(conv)

plot(freq, abs.(inverse))
