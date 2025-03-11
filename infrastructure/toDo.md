# Splitting startup script
Because gcp startup scripts are all executed as root, or perhaps because certain 
services need to be restarted during the course of the installation of the intel
compiler suite and then lammps, cmake does not work at the end of the full startup
script.

For this reason we have had the idea to break the startup scripts into 3 parts. We
can have the initial apt-get and apt install phase which is fine to execute as root;
but then afterwards we will install the intel compiler, lammps, and run the lammps
cmake and make as the user we want. This could be done with the setUpVm.sh script,
like this: 

sleep || script which waits for intial startup script to end
gcloud compute ssh USER@INSTANCE --command "bash -s" < installIntelCompiler.sh
sleep || script which waits for intel installtion  script to end
gcloud compute ssh USER@INSTANCE --command "bash -s" < script.sh

**Turns out this was not necessary, startupScript.sh works fine if appropriate chowns are made**.

# Separate and hide configuration
- Make a .env file and a .env_sample file where we input the service account name
  we want and other things like this. Or else just replace the values in the scripts
  with environment variables.

# setUp specific IAM profile

We do not need the full editor permissions that come with the default compute engine service
account. All we need really is to be able to copy things from gcs, and perhaps then just 
view some other things. So a "viewer" permission, along with copy from gcs rights should be
enough.

The setup of this profile can be done in the setUpVm.sh script with a gcloud command. You would
make it first in the UI and then just do "get equivalent code".
