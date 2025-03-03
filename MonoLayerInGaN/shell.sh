#!/bin/bash


for i in `seq 1 20`
do 
   mkdir Config${i}
   cd Config${i}
   cp ../Pots .
   sed -e 's_XXX_'${i}'_g' ../PreProc.pbs > PreProc.pbs
   qsub PreProc.pbs
   cd ../
done
