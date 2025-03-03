#!/bin/bash
nx=64
ny=64
nz=40

first=0

x=0
while ! [ -s Indium.txt ]
do
   x=`echo "$x+1" | bc`
   firstAtom=$(awk -v a="$x" -v b="$nx" -v c="$ny" 'BEGIN {print ((a-1)*2*b*c + 1+ 3) }')  # This gives the first atom of layer nz=$x. the +3 is because in sup_corr2.dat the atoms start at line 4.
   lastAtom=$(awk -v a="$x" -v b="$nx" -v c="$ny" 'BEGIN {print ( a*2*b*c + 3) }')        # Last atom of layer x
   sed -n "${firstAtom},${lastAtom}p" supercell_corr2.dat | grep "In" > Indium.txt  # This checks all atoms in layers below x for In atoms.
done

echo "The first layer in z to contain indium atoms is $x      ----wwfstart"
wwfstart=$x

while [ -s Indium.txt ]
do
   x=`echo "$x+1" | bc`
   firstAtom=$(awk -v a="$x" -v b="$nx" -v c="$ny" 'BEGIN {print ((a-1)*2*b*c + 1+ 3) }')  # This gives the first atom of layer nz=$x. the +3 is because in sup_corr2.dat the atoms start at line 4.
   lastAtom=$(awk -v a="$x" -v b="$nx" -v c="$ny" 'BEGIN {print ( a*2*b*c + 3) }')        # Last atom of layer x
   sed -n "${firstAtom},${lastAtom}p" supercell_corr2.dat | grep "In" > Indium.txt  # This checks all atoms in layers below x for In atoms.
   
   num=`wc -l Indium.txt | awk -v i=1 '{printf "%d", $(i)}'`
   if [ $num -gt 70 ] && [ $first != 1 ] 
   then
      echo "The first layer to contain > 100 Indium atoms is $x     ----kmin"             # 344 is the number of cations in the WWF, 70 is > 20% of this. If a layer has more indium atoms than this then it's definitely not the WWF, and is kmin.
      first=1
      kmin=$x
   fi
   
done

x=$[$x-1]
kmax=$x
echo "The last  layer in z to contain indium atoms is $x      ----kmax"
rm Indium.txt

n_cations=$(awk -v a="$nx" -v b="$ny" -v c="$kmax" -v d="$wwfstart"  'BEGIN {print ( a*b*(c-d+1) ) }')  #

cat supercell_corr2.dat | grep "In" > Indium.txt
num=`wc -l Indium.txt | awk -v i=1 '{printf "%d", $(i)}'`
comp=$(awk -v a="$num" -v b="$n_cations" 'BEGIN {print (a/b) }')         
echo "The indium content is: $comp"
rm Indium.txt
