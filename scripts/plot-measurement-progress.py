import matplotlib.pyplot as plt
import matplotlib
import numpy as np
from scipy import stats
import sys
import time
import datetime
from okabeito import blue, red

matplotlib.style.use("flab")


def convert_date(d):
    return time.mktime(datetime.datetime.strptime(d, "%Y-%m-%d").timetuple()) / 86400.0


xs = []
ys = []

for line in sys.stdin:
    raw_date, measurement = line.strip().split(" ")
    date = convert_date(raw_date)
    if not xs:
        first_date = date
    xs.append(date - first_date)
    ys.append(float(measurement))

xs = np.array(xs)
ys = np.array(ys)

res = stats.linregress(xs, ys)

fig, ax = plt.subplots()
ax.scatter(xs, ys, s=64, color=blue)
ax.plot(xs, res.intercept + res.slope*xs, red)
ax.set_title(f"Slope: {res.slope}\np-value: {res.pvalue}")
plt.show()
