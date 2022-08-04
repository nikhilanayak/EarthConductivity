import matplotlib.pyplot as plt
import pandas as pd

df = pd.read_csv("out.csv")


plt.plot(df.col, df.amplitude, label="K(X)")
plt.plot(df.col, df.x, label="X")
plt.legend()

plt.show()
