#!/bin/bash

# The purpose of this script is to determine the random seed that was used in 
# these configurations, as in the first 25 configs, we did not know what the
# random seed was.

for i in Config*
do
N=$(echo $i | awk 's=substr($1,7,2) {print s}')

#yes=$(echo $N | awk '{if ('$N' >= 11)  print $0  else   print $1}')

if [ $N -gt 10 ] 
then
echo $i;
echo $N;
echo $yes

cmp Config$N/supercell_corr2.dat ../10/${N}_Config/supercell_corr2.dat
fi

done
