#!/bin/bash

if [ ! -f .env ]; then
  echo -e "Error: No .env file.\nCopy .env_sample to .env and fill it in"
  exit 1
fi

source .env
declare -A neededParams=( [name]="$name"        [bootDiskName]="$bootDiskName" [sshKeyPath]="$sshKeyPath" 
                          [machine]="$machine"  [bootDiskSize]="$bootDiskSize" [project]="$project" )

for key in "${!neededParams[@]}" 
do
  if [ -z "${neededParams[$key]}" ] 
  then
    echo "Error: The parameter '$key' is not set. See .env_sample and create.env file" 
    exit 1
  fi
done

gcloud compute instances create ${name} \
--project=${project} \
--zone=europe-west1-d \
--machine-type=${machine} \
--metadata-from-file=startup-script=startUpScript.sh,ssh-keys=${sshKeyPath} \
--maintenance-policy=MIGRATE \
--provisioning-model=STANDARD \
--scopes=https://www.googleapis.com/auth/cloud-platform \
--create-disk=auto-delete=yes,boot=yes,device-name=${bootDiskName},\
image=projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20250305,mode=rw,size=${bootDiskSize},type=pd-balanced \
--no-shielded-secure-boot \
--shielded-vtpm \
--shielded-integrity-monitoring \
--labels=goog-ec-src=vm_add-gcloud \
--reservation-affinity=any 


# If you want to use an external ip address you can add this line.
#--network-interface=address=${externalIp},network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
# If you want to manually specify a tailored service account: 
#--service-account=${serviceAccount}

# Here is how to see how the startup script run went:
# From your local computer: 
# gcloud compute instances get-serial-port-output big-money-vm --zone=europe-west1-d
# Or while connected to the VM:
# sudo journalctl -u google-startup-scripts.service

gcloud compute instances get-serial-port-output $name --zone=europe-west1-d | grep startup-script | sed 's/^.*startup-script: //' 

