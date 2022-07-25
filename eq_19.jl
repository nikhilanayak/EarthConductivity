Ls = [15, 10, 125, 200]
res = [20000, 200, 1000, 100]
Sigmas = [0, 0, 0, 0, 0]

N = 5 # num layers

mu = 4 * pi * 10^-7


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
	if n == N
		return K_N(f)
	end

	K_NPrev = K(n+1, f)
	e = eExpression(n, f)
	
	num = K_NPrev * (1 + e) + eta(n, f) * (1 - e)
	den = K_NPrev * (1 - e) + eta(n, f) * (1 + e)
	
	return eta(n, f) * num / den
end
