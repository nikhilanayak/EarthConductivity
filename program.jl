using Printf


function help()
	@printf("Run like so: julia %s [recreate|load]\n", PROGRAM_FILE)
	println("- recreate: recreates the data from the Boteler 2019 Paper")
	println("- load [FILE]: loads [FILE] as a FSIM file and uses the data as input to the transfer function. Writes data as CSV to stdout. If you don't have a FSIM file, try out data.txt")

	exit(-1)
end


if length(ARGS) == 0
	help()
	end

 

using PyPlot
using CSV

Ls = [15, 10, 125, 200]*1e3
res = [20000, 200, 1000, 100]
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


if ARGS[1] == "recreate"
  println("Table 3. Transfer function K(f) for the frequencies in the synthetic test
magnetic field variation for a multi-layer Earth (5-layer Québec model).")

	
	freqs = [0.000093, 0.000208, 0.000476, 0.001111, 0.002381, 0.005556, 0.025] 

	iter = 0
	for freq in freqs
		global iter = iter + 1

		res = K(1, freq)/1e3

		amp = abs(res)	
		phas = angle(res) * 180 / pi

		@printf("%d | %.6f | %.6f | %.6f\n", iter, freq, amp, phas)
	end


	println("\nTable 7. Parameters of electric field waveform for a multi-layer Earth
(5-layer Québec model).")

	tableOnePhase = [10, 20, 30, 40, 50, 60, 70]
	tableOneAmp = [200, 90, 30, 17, 8, 3.5, 1]


	iter = 0
	for freq in freqs
		global iter = iter + 1

		res = K(1, freq)/1e3

		amp = abs(res) * tableOneAmp[iter]
		phas = angle(res) * 180 / pi + tableOnePhase[iter]

		@printf("%d | %.6f | %.6f | %.6f\n", iter, freq, amp, phas)

	end
	

	exit(0)
end
if ARGS[1] == "load"
	file = ARGS[2]

	reader = readlines(file)

	println("col x amplitude phase")

	ind = 0
	for line in reader
    if startswith(line, "#")
      continue
    end
    global ind += 1

    cols = split(line, " ")
    X = parse(Float64, cols[2])


		res = K(1, X) / 1e3
		amp = abs(res)
		phas = angle(res) * 180 / pi

		@printf("%d, %.3f, %.3f, %.3f\n", ind, X, amp, phas)
	end


	exit(0)
end
help()



# The 1000x scaling factor is just units
# 1 mV/(km*nT) = 1000 V/(m*T)
# so your calculations are fine!
