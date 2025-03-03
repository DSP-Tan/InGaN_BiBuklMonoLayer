#!/bin/bash

# This script runs diagnostics on the supercells of all configurations and prints them to a file.

# Must first make supercell folders and put all supercell stuff in there.
# Must make "atoms of upper interface" and "atoms of lower interface", and edit
# Wellwidth.c to accommodate the format.
# Run wellwidth and get before and after relaxation widths.
# run Indiun content determination code.

nx=32
ny=32

kstart=22
kend=32

LowerFirstAtom=$(awk -v a="$kstart" -v b="$nx" -v c="$ny" 'BEGIN {print ((a-1)*2*b*c + 1+ 3) }')  # This gives the first atom of layer nz=$x. the +3 is because in sup_corr2.dat the atoms start at line 4.
LowerLastAtom=$(awk -v a="$kstart" -v b="$nx" -v c="$ny" 'BEGIN {print ( a*2*b*c + 3) }')        # Last atom of layer x

UpperFirstAtom=$(awk -v a="$kend" -v b="$nx" -v c="$ny" 'BEGIN {print ((a-1)*2*b*c + 1+ 3) }')  # This gives the first atom of layer nz=$x. the +3 is because in sup_corr2.dat the atoms start at line 4.
UpperLastAtom=$(awk -v a="$kend" -v b="$nx" -v c="$ny" 'BEGIN {print ( a*2*b*c + 3) }')        # Last atom of layer x

rm Summary_Of_Supercells.txt
for i in `seq 6 25`
   do
   cd RC_${i}/Supercell;
   echo "Configuration ${i}" >> ../../Summary_Of_Supercells.txt
   ../../MaxMinFinder.sh >> ../../Summary_Of_Supercells.txt
   ../../Well positions.dat  > fart.txt
   tail -n 1 fart.txt >> ../../Summary_Of_Supercells.txt
   echo "----------------------------------------------" >> ../../Summary_Of_Supercells.txt
   echo "  " >> ../../Summary_Of_Supercells.txt
   cd ../..
   done
