# InGaN
Make 1 readme for the workflow for all work structure classes, with subsections stating how compile_execute is 
executed differently for the different classes. The readme you have in the bulk section can serve as a first
approximation to this redmea. This readme can be expanded with a less form inside the bulk repo. 

The classes will be Mono/BiLayer, greenGap, and wellWith. In each of these subfolders
we can also have either the associated paper or a link to it.

- Make notes about the fact that the data are only example data and can be recreated.

# Incorporate the matrix diagonalisation and localisation length code 

The data themselves will be contained else where. Either in tyndall-work documents, or on a
hard drive containing the old local laptop data.


# misc
in.pppm is the same everywhere, we will keep this outside the best version of it. You must
make sure it is the same first, and that you are keeping the best one.

In each configurations folder we will have the same shell but a different Preproc.pbs and then
Start_lmpath may be the same or not.

As this directory is going to contain all the InGaN calculations, you will need to re-name it and
also re-arrange it.


Use the two gulpToLammps codes, and then delete the old one. Or just delete the old one straight out,
we already know they have been tested. Ok so just delete the older one and keep the newer one. 
Keepign them both is retarded.

It looks like this Config1 of green is not working because of different WWF placement


You must include all details of the lammps build with perhaps some makefiles or whatever. Do an
auto copy of the zip to the new vm and just do the make there.



# We sould have different branches for different configurations.
  - Old pre-compiled feb16 lammps (copy from gcp)
  - Freshly downloaded lammps (with git)
  - Make sure the different compiler options for both preproc codes are there in the makefile.

# infrastructure

Uploading a startup script via gcp on vm creation is one way. You could also just create
the vm, and then ssh in as your user and run the script which is stored locally. This
might be easier. The script would either be uploaded after vm creation or it could be
kept local and executed from there.

All these commands could be executed just at the end of setUpVm.sh. After an appropriate sleep time
to give it a chance to start up.

It is probably not so safe to be doing all these "assume-yes" and git clonings as root on the vm.
Probably it would be a good idea to ensure that the default vm service account cannot create other
vms or do some other harmful things.

For this reason it's a good idea to hide the names of your service accounts as well in the github
page.

# Supercell code
You do not need two "supercell.f" supercell_sub and supercell_well to be stored. They are the same
code except for the indium content, so just have the compile_execute change just these parts.

The x-y location of the wwf needs to be set. This is what explains the difference between the 
energies you calculated and those calculated in the old greengap code. Just do a diff on the composite.f
codes contained in the Config one of the green 5% and you will see it. It seems your central wwf
position was set to the value it would have for the large mono/biylayers.

Remember that in Cluster/GulpToLammpses there are more updated versions of the code than that contained
in SRC_Ver_Jan I tihnk it's something to do with using qsort rather than bubble sort, or just 
saying as much. Anyway you can copy over these changes.
