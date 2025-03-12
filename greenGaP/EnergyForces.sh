#!/bin/bash
rm Forces.txt
rm Energies.txt
for i in `seq 31 105`
do
 echo ${i} >> Forces.txt
 #sed -n 91,92p Config${i}/log.lammps >> Forces.txt
 #sed -n 199,200p Config${i}/log.lammps >> Forces.txt
 sed -n '/Force max component initial/p' Config${i}/log.lammps >> Forces.txt
 echo ${i} >> Energies.txt
 cat Config${i}/log.lammps | grep -A 2 "Step PotEng E_bond E_pair E_angle" >> Energies.txt
done
