using FFTW
using PyPlot
using Trapz
using Statistics



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


function dBdT(t)
	y = 0
	for i in 1:7
		y += 2 * pi * f[i] * A[i] * cos(
						2 * pi * f[i] * t
						+ (pi / 180 * Phi[i])
					)
	end
	return y
end


function K(x) # Equation (13)
	mu = 4 * pi * 10e-7
	sigma = 1000
	i = 1im
	
	return sqrt(
		(i * 2 * pi * x) / 
		(mu * sigma)
	)
end


function C(x)
	i = 1im
	return K(x) / (i * 2 * pi * x)
end


function E(x)
	#return C(x) * dBdT(x)
	return K(x) * B(x)
end


function fourier_series(t, x, f0, ks)
	_, ak, bk, fs = fsc(t, x, f0, ks)
	f = (ak - 1im * bk)
	return f, fs
end


function fsc(t, x, f0, ks)
	ak = zeros(1, length(ks))
	bk = zeros(1, length(ks))

	T = maximum(t) - minimum(t)
	w0 = 2*pi*f0
	fs = f0*ks

	for n in 1:length(ks)
		k = ks[n]

		ak[n] = 2 * trapz(t, x.*cos.(k*w0*t))/T
		bk[n] = 2 * trapz(t, x.*sin.(k*w0*t))/T

	end
	return f0, ak, bk, fs
end


function phasor(t, x, f)
	xh, _ = fourier_series(t, x, f, 1)
	return xh[1]
end



timestep = 1 # n second timestep

X = 1:timestep:86400 # 1 day, with a timestep from above
# X = vcat(X...)

Y = B.(X) # Figure 6

freq = fftfreq(length(Y), timestep)

# conv = K.(freq) .* fft(Y)


plot(freq, abs.(fft(Y)))

#plot(X, Y)
#xlabel("Time (Seconds)")
#ylabel("Synthetic Field Variation nT)")

#println(abs(phasor(X, Y, 0.00009259)))
#println(abs(phasor(X, Y, 0.00020833)))
