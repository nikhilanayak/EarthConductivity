Ls = [15, 10, 125, 200]
using Printf

Ls = [15, 10, 125, 200]*1e3
res = [20000, 200, 1000, 100]
#Sigmas = [1, 1, 1, 1, 1]
Sigmas = [1/20000, 1/200, 1/1000, 1/100, 1/3]

# Sigmas[end] = 1/1000 # testing with half-space model



N = 5 # number of layers in the model

mu = 4 * pi * 10^-7 # µ, defined below equation 2
i = 1im # √-1


function K_N(f) # top layer of the model, equation 16
	return sqrt((i * 2 * pi * f) / (mu * Sigmas[N]))
end


function k(n, f) # equation 4
	return sqrt(i * 2 * pi * f * mu * Sigmas[n])
end

function eta(n, f) # η, defined below equation 18
	return i * 2 * pi * f / k(n, f)
end


function eExpression(n, f) # e ^ (-2knln)
	return ℯ ^ (-2 * k(n, f) * Ls[n])
end

function K(n, f) # Equation 19
	#println("in layer ", n)
	if n == N
		return K_N(f)
	end

	K_NPrev = K(n+1, f)
	e = eExpression(n, f)
	
	num = K_NPrev * (1 + e) + eta(n, f) * (1 - e)
	den = K_NPrev * (1 - e) + eta(n, f) * (1 + e)
	
	return eta(n, f) * num / den
end

# The 1000x scaling factor is just units
# 1 mV/(km*nT) = 1000 V/(m*T)
# so your calculations are fine!
Kf = K(length(Sigmas), 0.025)/1e3 
Kf = K(1, 0.025)/1e3 
Kf = K(1, 0.000093)/1e3
Kf = K(1, 0.001111)/1e3 

println(abs(Kf))
println(angle(Kf)*180/pi)
@printf("Mag: %0.4f, Angle: %0.2f\n", abs(Kf), angle(Kf)*180/pi)
