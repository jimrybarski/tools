import matplotlib.pyplot as plt
import matplotlib
import sys
import time
import datetime
from okabeito import red, blue

matplotlib.style.use("flab")


def convert_date(d):
    return time.mktime(datetime.datetime.strptime(d, "%Y-%m-%d").timetuple())


xs = []
young_ys = []
mature_ys = []

for line in sys.stdin:
    raw_date, young, mature = line.strip().split(" ")
    date = convert_date(raw_date)
    xs.append(date)
    young_ys.append(int(young))
    mature_ys.append(int(mature))

fig, ax = plt.subplots()
ax.scatter(xs, young_ys, s=64, color=red)
ax.scatter(xs, mature_ys, s=64, color=blue)
plt.show()
