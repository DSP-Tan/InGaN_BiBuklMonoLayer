#!/bin/bash


for i in `seq 2 20`
do 
   #mkdir Config${i}
   cd Config${i}
   #sed -e 's_XXX_'${i}'_g' ../PreProc.pbs > PreProc.pbs
   sed -e 's_XXX_'${i}'_g' ../Start_lmpath.pbs > Start_lmpath.pbs
   #qsub PreProc.pbs
   qsub Start_lmpath.pbs
   cd ../
done
