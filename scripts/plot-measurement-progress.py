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

LATEST_DAYS = 14
latest_ys = ys[-LATEST_DAYS:]
latest_xs = xs[-LATEST_DAYS:]
mean = round(np.mean(latest_ys), 1)
std = round(np.std(latest_ys), 1)
res = stats.linregress(latest_xs, latest_ys)

fig, ax = plt.subplots()
ax.scatter(xs, ys, s=64, color=blue)
ax.plot(latest_xs, res.intercept + res.slope*latest_xs, red)
ax.set_title(f"Slope: {res.slope}\np-value: {res.pvalue}\nCurrent: {mean} +/- {std}")
plt.show()
