#!/bin/bash

# Currently it is the windows computer ssh key that is uploaded. When you do a gcloud compute ssh it
# uploads the ubuntu one automatically. You can check this in the metadata once the first connection is
# made. you should then see two ssh keys.

#name=small-money-vm
name=test1-money-vm
#machine=e2-standard-4           # This is what le wagon says in setup.
machine=e2-standard-4
#machine=e2-highcpu-8
serviceAccount=big-money-service@bigmoneydata.iam.gserviceaccount.com
bootDiskSize=25                  # You need at least 14.5 Gb for the intel compiler suite.
externalIp=104.199.67.65         # If you are using an external ip, the one you reserved goes here. You can probably also
                                 # use the name of your external ip.

sshKeyPath=/home/daniel/.ssh/deng_key.pub 


gcloud compute instances create $name \
--project=bigmoneydata \
--zone=europe-west1-d \
--machine-type=$machine \
--metadata-from-file=startup-script=startUpScript.sh,ssh-keys=$sshKeyPath \
--maintenance-policy=MIGRATE \
--provisioning-model=STANDARD \
--service-account=791114692313-compute@developer.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/cloud-platform \
--create-disk=auto-delete=yes,boot=yes,device-name=big-money-vm,image=projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20240904,mode=rw,size=${bootDiskSize},type=pd-balanced \
--no-shielded-secure-boot \
--shielded-vtpm \
--shielded-integrity-monitoring \
--labels=goog-ec-src=vm_add-gcloud \
--reservation-affinity=any \
--service-account=${serviceAccount}

# Here's an example of what it would look like if you pasted the ssh key directly in:
#--metadata=ssh-keys=Henri:ssh-rsa\ AAAAB3NzaC1yc2EAAAADAQABAAABAQC39ttWgVVnvma8zggQSo1wrYFlRlPA3kRKMb7+YOhXyJD+LpUFbYnguyYDpWKXucIKIE/KssOZk1v/vt12/RjGqL+Qf9lVOTr3fNzsr1eaNNGty1zBu7Eg22ViWN/LHBWrMbwYB+pqQ8XLZYehLNjJ9DYkcWwXKyV1nKAHF9TrfmQ8TmDadGQkPg2TaVvQrB2Z14PVSSe3GCPLGADco4V+xHc670rNaDtRjnbX1Sx6quwrQzI3xKAEeKYxukRZMW5ZxSHeE0EHPz46/CNXpf6QWLTGfIjN1y4szYZgt8ZvplUGDv/X1JbVkeZCCUXCO4KrhYsUTvaVdnItkbLsGEUF\ Henri@jersey \

# If you want to use an external ip address you can add this line.
#--network-interface=address=${externalIp},network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \

# Here is how to see how the startup script run went:
# gcloud compute instances get-serial-port-output big-money-vm --zone=europe-west1-d
#
# gcloud compute instances get-serial-port-output test1-money-vm --zone=europe-west1-d \
# | grep startup-script | sed 's/^.*startup-script: //' > testMoneySerial.txt
