This folder contains code for the generation, preprocessing, relaxation,
and postprocessing of 20 bulk InGaN random supercells. Note here we have
kept only 2 example configurations, the first and the last. The rest can
be reproduced by setting "XXX" to the configuration number in the below
scripts.

# Generation

The supercell generation is implemented using the fortran code in supercellSRC:
../../../SupercellSRC/compile_execute_QW_InGaN XXX 25 1 40 false 0 0

Here compile_exeucte_QW_InGaN compiles and executes the fortan code contained in SupercellSRC, 
in order to generate an random InGaN supercell. It has the arguments:

XXX   - The configuration number and random number seed for the distribution of indium atoms.
25    - The indium content.
1     - Where the well starts (start of supecell)
40    - Where the well ends   (end of supercell, this is bulk so it's all the QW)
false - Include wwf? Here we say no.
0     - This is wwfstart
0     - This is wwfend

We need not have done this way, but using compile execute like this makes it consistent with
other previously done well width calculations. The supercell dimensions set in supercellsub.f
are nx=64, ny=64, nz=40

More information on the supercell generation can be found in the directory: `../../../SupercellSRC/`

The pbs script PreProc.pbs is then used for each configuration to submit the job to run on 1 core
on the cluster.

The fortran code triggered by `../../../SupercellSRC/compile_execute_QW_InGaN` will produce, amongst
other things, the supercell file: supercell_corr2.dat. It is this file which is important for
subsequent steps.

`AtomsinDisk.dat`, `AtomsOfUpperQW_Plane.dat`, `AtomsOfLowerQW_Plane.dat` will also be produced but they 
are not relevant in the case of BulkInGaN and can be deleted.

The script shell.sh was used to run this for all 20 bulk InGaN supercells.

# Preprocessing

Before the relaxation, this super cell must be put in a form usable by lammps. In particular the bonding
and angle topology of the supercell must be specified. To do this the code in `../../../SRC_Ver_Jun2016`
is executed like this:

`../../../SRC_Ver_Jun2016/mai  supercell_corr2.dat ../../../SRC_Ver_Jun2016/Pots`

This will output data.lammps which can now serve as input for lammps and the relaxation.

# Relaxation

With `data.lammps` prepared, we can now use lammps to minimise the crystal energy following the
instructions in `in.pppm`. The in.pppm file is heavily commented to justify each of the choices
made for the parameters of minimisation and methodology used. 

Running on the sfi cluster at tyndall, `Start_lmpath.pbs` submitted the minimisation job to run on 8 cores using
the pgi/mpi-parallelised version of lammps; several configurations were minimised at once in separate jobs each using 
8 cores. 

However if you would like to test this locally it is very easy to install a serial version of lammps by downloading 
the tar and simply running `make serial` in the src directory.

The lammps relaxation job, as implemented in `Start_lmpath.pbs` will produce: `log.lammps`, `NewLammps.txt`, and `dump.lammps`,
of which only `dump.lammps` and `log.lammps` need to be kept for the next step.

# Post Processing

The final part of the postprocessing converts the lammps output to a form suitable for Stefan's C++ tight binding
code which will construct the TB Hamiltonian. This simple re-structuring of the output is performed by `Positions.c`.
This code could be compiled with: 
```bash
gcc Positions.c -lm -o Posish
```
This will produce positions.dat, which will be the input to the text TB Hamiltonian construction stage. The way it is
run in Start_lmpath.pbs:
```bash
../Posish log.lammps supercell_corr2.dat dump.lammps > PositionsOutput.txt
```
Will also produce PositionsOutput.txt, which can just be deleted.




