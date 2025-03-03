#!/bin/bash

# This script was used to first create the supercells and define bonding topology
# for all 20 configurations. This is done using PreProc.pbs which calls on:
#
# 1.
# ../../../SupercellSRC/compile_execute_QW_InGaN XXX 25 1 40 false 0 0
# to generate the supercell, where XXX is the configuration and random seed number;
#
# 2.
# /sfihome/daniel.tanner/GulpToLammpsSRC/SRC_Ver_Jun2016/mai supercell_corr2.dat /sfihome/daniel.tanner/GulpToLammpsSRC/SRC_Ver_Jun2016/Pots > mai.txt
# To define the bonding topology and the lammps relaxation input.
#
# Both of these calculations are performed on one core, though updated versions of these codes
# have been parallelised.


for i in 2 #`seq 13 20`
do 
   mkdir -p Config${i}
   cd Config${i}
   sed -e 's_XXX_'${i}'_g' ../PreProc.pbs > PreProc.pbs
   sed -e 's_XXX_'${i}'_g' ../Start_lmpath.pbs > Start_lmpath.pbs
   #qsub PreProc.pbs
   #qsub Start_lmpath.pbs
   cd ../
done
