#!/usr/bin/python3

from datetime import datetime
from slugify import slugify
from pathlib import Path
import os
import sys
import subprocess


dt = datetime.strftime(datetime.today(), "%Y-%m-%dT%H:%M:%S-06:00")

print("\n\n")
title = input("Blog post title (press enter to abort): ")
if not title:
    exit(0)


desc = input("Description (press enter to leave blank): ")
tags = tuple(map(str.strip, input("Tags (space separated): ").lower().split()))
tags = ", ".join([f"\"{tag}\"" for tag in tags])

slugified_title = slugify(title)
filename = f"{slugified_title}.md"

header = f"""+++
title="{title}"
description="{desc}"
date="{dt}"
[taxonomies]
tags = [{tags}]
+++\n\n"""

home = str(Path.home())
filepath = os.path.join(home, 'blog', 'content', filename)

print("\n\n")
print(f"Title: {title}")
print(f"Filename: {filepath}")
print(f"Header:\n{header}")
print("")

bad = input("Type anything if bad, press enter if ok")
if bad:
    exit(1)

with open(filepath, "w") as f:
    f.write(header)

subprocess.run(['nvim', filepath])
