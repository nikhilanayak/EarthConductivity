Ls = [15, 10, 125, 200]
res = [20000, 200, 1000, 100]
#Sigmas = [1, 1, 1, 1, 1]
Sigmas = [1/20000, 1/200, 1/1000, 1/100, 1/3]

N = 5 # num layers

mu = 4 * pi * 10^-7
i = 1im


function K_N(f)
	return sqrt((i * 2 * pi * f) / (mu * Sigmas[N]))
end


function k(n, f)
	return sqrt(i * 2 * pi * f * mu * Sigmas[n])
end

function eta(n, f)
	return i * 2 * pi * f / k(n, f)
end


function eExpression(n, f)
	return ℯ ^ (-2 * k(n, f) * Ls[n])
end

function K(n, f)
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


println(
	K(1, 1)
)
