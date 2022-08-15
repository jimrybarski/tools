#!/usr/bin/env python3

import sys

def ssdna_mw(sequence):
    mw= {"A": 313.2, 
         "T": 304.2, 
         "C": 289.2, 
         "G": 329.2,
         "N": 309.0}
    return sum([mw[nucleotide] for nucleotide in sequence])


def ssrna_mw(sequence):
    mw= {"A": 329.2, 
         "U": 306.2, 
         "C": 305.2, 
         "G": 345.2,
         "N": 309.0}
    return sum([mw[nucleotide] for nucleotide in sequence])



def dsdna_mw(sequence):
    return ssdna_mw(sequence) * 2


if len(sys.argv) < 3 or sys.argv[2] not in ("ss", "ds"):
    print("Usage: {} SEQUENCE [ss|ds] [dna|rna] [ng/uL]".format(sys.argv[0]))
    exit(1)

sequence = sys.argv[1].strip().upper()
strandedness = sys.argv[2]
dna_or_rna = sys.argv[3]
if set(sequence) > set("ACGTUN"):
    print("Your sequence doesn't look like DNA or RNA.")
    exit(2)

if dna_or_rna == "dna":
    mw = ssdna_mw(sequence) if strandedness == "ss" else dsdna_mw(sequence)
elif dna_or_rna == "rna":
    mw = ssrna_mw(sequence)
else:
    print("Invalid nucleotide type.")
    exit(3)

length = len(sequence)

if len(sys.argv) > 3:
    try:
        ngul = float(sys.argv[4])
    except:
        print("Invalid concentration")
        exit(4)
    micromolarity = ngul * 10**3 / mw

print("")
print("MW: %.1f g/mol" % mw)
units = "nt" if strandedness == "ss" else "bp"
print("Length: {length} {units}".format(length=length, units=units))

if len(sys.argv) > 4:
    print("%.1f uM" % micromolarity)
    print("%.1f nM" % (micromolarity * 1000))

# For diluting primers to the standard concentration of 10 uM, we assume
# the procedure of adding 80 uL Te and 10 uL ~100 uM primer stock, and a 2 uL
# sample used for determine concentration on the nanodrop.
if micromolarity > 10.0 and dna_or_rna == "dna" and strandedness == "ss":
    add_buffer = (88*micromolarity/10.0) - 88
    print("To get 10 uM, add %.1f uL to 88 uL" % add_buffer)
