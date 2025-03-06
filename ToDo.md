# Make 1 readme for all cases, with subsections stating how compile_execute is 
# executed differently for the different cases.

# Make notes about the fact that the data are only example data and can be recreated.

# Incorporate the matrix diagonalisation and localisation length calculation code and 
# data which will be contained else where. Either in tyndall-work documents, or on a
# hard drive containing the old local laptop data.

# The readme you have in the bulk section needs to be moved to this outer section, and then
# for each supercell type you will have a smaller readme of the kind that is in the monolayer
# part.


# in.pppm is the same everywhere, we will keep this outside the best version of it. You must
# make sure it is the same first.

# In each configurations folder we will have the same shell but a different Preproc.pbs and then
# Start_lmpath may be the same or not.

# As this directory is going to contain all the InGaN calculations, you will need to re-name it and
# also re-arrange it.


# Use the two gulpToLammps codes, and then delete the old one. Or just delete the old one straight out,
# we already know they have been tested. Ok so just delete the older one and keep the newer one. 
# Keepign them both is retarded.


# In our setupVM script lets just use the feb16 version of lammps and do the ompi installation

# Make it so that we get the intel fortan compiler too.

# It looks like this Config1 of green is not working but that is not worht further investigating

# Just get the autosetup done and and then ship it.

# You must include all details of the lammps build with perhaps some makefiles or whatever. Do an
# auto copy of the zip to the new vm and just do the make there.

# Also do the new version of lammps


# We sould have different branches for different configurations.
  - Old pre-compiled feb16 lammps (copy from gcp)
  - Freshly downloaded lammps (with git)
  - Make sure the different compiler options for both preproc codes are there in the makefile.

# Uploading a startup script via gcp on vm creation is one way. You could also just create
# the vm, and then ssh in as your user and run the script which is stored locally. This
# might be easier. The script would either be uploaded after vm creation or it could be
# kept local and executed from there.

# All these commands could be executed just at the end of setUpVm.sh. After an appropriate sleep time
# to give it a chance to start up.
