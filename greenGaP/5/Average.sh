#!/bin/bash

# This cript returns the average size in the C lattice vector direction of all the configs.

for i in Config*; do  tail $i/log.lammps | grep 'c= [0-9][0-9]*'; done | awk '{s += $2} END {printf "%10.5f\n" ,s/NR}'
