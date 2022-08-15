import sys
from typing import Tuple
from datetime import date
from os.path import expanduser


def parse_time(s: str) -> Tuple[int, int]:
    assert len(s) == 4 # 24 clock only, no mercy for errors
    hours = s[:2]
    minutes = s[2:]
    return int(hours), int(minutes)


def calculate_minutes(sleep: Tuple[int, int], wake: Tuple[int, int]):
    sh, sm = sleep
    wh, wm = wake
    if wh < sh:
        wh += 24
    if wm < sm:
        wm += 60
        wh -= 1
    return (wh - sh) * 60 + (wm - sm)

caffeine = int(input("How many caffeinated beverages today did you have yesterday?"))
total = 0

sleeps = []

while True:
    sleep = parse_time(input("What time did you fall asleep?"))
    wake = parse_time(input("What time did you wake up?"))
    minutes = calculate_minutes(sleep, wake)
    sleeps.append(minutes)
    total += minutes
    more = input("More cycles? (press enter for no)")
    if not more:
        break

comments = input("Comments?")
today = date.today()
d = today.strftime("%Y-%m-%d")
fstring = "{date} caffeine:{caffeine} sleeps:{sleeps} total:{total}"
if comments:
    fstring = "%s # {comments}\n" % fstring
else:
    fstring = "%s {comments}\n" % fstring

home = expanduser("~")
with open("{home}/sleep.log".format(home=home), "a") as f:
    f.write(fstring.format(date=d, caffeine=caffeine, sleeps=",".join(map(str, sleeps)), total=total, comments=comments))
