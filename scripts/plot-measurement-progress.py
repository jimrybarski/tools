import matplotlib.pyplot as plt
import matplotlib
import sys
import time
import datetime
from okabeito import blue

matplotlib.style.use("flab")


def convert_date(d):
    return time.mktime(datetime.datetime.strptime(d, "%Y-%m-%d").timetuple())


xs = []
ys = []

for line in sys.stdin:
    raw_date, measurement = line.strip().split(" ")
    date = convert_date(raw_date)
    xs.append(date)
    ys.append(float(measurement))

fig, ax = plt.subplots()
ax.scatter(xs, ys, s=64, color=blue)
plt.show()
