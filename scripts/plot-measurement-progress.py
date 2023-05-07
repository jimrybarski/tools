import matplotlib.pyplot as plt
import matplotlib
import numpy as np
from scipy import stats
import sys
import time
import datetime
from okabeito import blue, red, green

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

res_all = stats.linregress(xs, ys)

LATEST_DAYS = 14
latest_ys = ys[-LATEST_DAYS:]
latest_xs = xs[-LATEST_DAYS:]
res = stats.linregress(latest_xs, latest_ys)

mean = round(res.intercept + res.slope*xs[-1], 1)

fig, ax = plt.subplots()
ax.scatter(xs, ys, s=64, color=blue)
ax.plot(latest_xs, res.intercept + res.slope*latest_xs, red)
ax.plot(xs, res_all.intercept + res_all.slope*xs, green)
ax.set_title(f"Two weeks: {round(res.slope * 365, 2)}/year, p-value: {round(res.pvalue, 3)}\nTotal: {round(res_all.slope * 365, 2)}/year, p-value: {round(res_all.pvalue, 3)}\nCurrent: {mean}")
plt.show()
