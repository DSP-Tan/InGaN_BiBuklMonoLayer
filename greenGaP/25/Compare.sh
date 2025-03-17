#!/bin/bash

for i in Config*
do
N=$(echo $i | awk 's=substr($1,7,2) {print s}')

#yes=$(echo $N | awk '{if ('$N' >= 11)  print $0  else   print $1}')

if [ $N -gt 10 ] 
then
echo $i;
echo $N;
echo $yes

cmp Config$N/supercell_corr2.dat ../25/${N}_Config/supercell_corr2.dat
fi

done
