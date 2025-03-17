#!/bin/bash


for i in `seq 156 180`
do 
   mkdir Config${i}
   cd Config${i}
   #cp ../Gul.txt .
   #cp ../Pots .
   #cat supercell_corr2.dat >> Gul.txt
   fart=`echo "${i}+370" | bc`
   echo "seed is $fart"
   sed -e 's_XXX_'${fart}'_g' ../PreProc.pbs > PreProc.pbs
   #mv Gul.txt Gulp.gin
   qsub PreProc.pbs
   cd ..
done
