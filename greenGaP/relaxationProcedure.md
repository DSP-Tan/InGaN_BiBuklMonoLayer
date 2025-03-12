Steps to performing relaxation:

1) Put cell dimensions at the top of supercell_corr2.dat. This is needed to give meaning to the fractional coordinates and is expected by the lammps conversion code.

The lammps conversion code takes in a file of the form:

cell
%lf %lf %lf - These are the a b c lattice constants
frac
%s %lf %lf %lf - name x y z
%s %lf %lf %lf
%s %lf %lf %lf

This is done automatically in mine and Josh's versions of the compile execute code. 

However, if you use the unmodified version of Miguel's supercell generation code, then this can be done in post processing.
This is why there is a file "Gul.txt" in each of the 10,15 and 25% "NewConfigs" folders. 
These are simply the headers of the file that will subsequently be read in to the lammps conversion file. 
The atomic coordinates are appended to the Gul.txt file in the shell script "shell.sh" or just "shell".

The code also takes in a file with all the information about the VFF potential. This is the file "Pots" and does not need to be changed. This file "Pots" is normally kept where the conversion code is kept.

2) Run conversion code.

The lammps conversion code is run:
./mai [supercell file with cell parameters at top] [Potentials File]

This code takes in the coordinates and then defines all the bonds and angles that lammps will account for.
The cutoffs for this code are those that were used in the GULP calculation. Care must be taken that supercells where
the atoms are too far apart are not put in intially. If this is the case then the code may not assign bonds between
atoms which should be bonded.

It takes around 40 minutes to finish. This is normally done by running each configuration on its own single core job all at once.
shell.sh gives an example of this.

3) Run lammps relaxation.

This can be done using the .pbs file "Start_lmpath.pbs"

4) Convert the lammps output to "positions.dat" files.

../Posish log.lammps Gulp.gin dump.lammps 

This can be done using the code "Positions.c", which takes in "log.lammps", "Gulp.gin" and "dump.lammps".
Compiled here as something like:  gcc Positions.c -lm -o Posish.

This may be done right after the lammps relaxation and is included in the "Start_lmpath" files.


