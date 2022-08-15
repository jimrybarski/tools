import sys

try:
    number = int(sys.argv[1])
except:
    print("Usage: script.py oJRR_NUMBER")
else:
    with open("/home/jim/phd2/database/oligos.csv") as f:
        for line in f:
            n, seq, description = line.split(" ", 2)
            if int(n) == number:
                print(seq)
                print(description)
                exit(0)
        print("Could not find oJRR %d" % number)
        exit(1)
