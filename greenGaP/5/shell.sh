#!/bin/bash

for i in `1 175` #`seq 151 175`
do 
   mkdir -p Config${i}
   cd Config${i}
   fart=`echo "${i}+1" | bc`
   echo "seed is $fart"
   sed -e 's_XXX_'${fart}'_g' ../PreProc.pbs > PreProc.pbs
   qsub PreProc.pbs
   rm PreProc.pbs
   cd ..
done
