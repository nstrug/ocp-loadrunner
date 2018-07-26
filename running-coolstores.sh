#!/usr/bin/env bash

# this is the number of coolstores we want to deploy
N_RUNNING_COOLSTORES=3


git clone https://github.com/jbossdemocentral/coolstore-microservice || true

cd coolstore-microservice
git pull

for (( I=1 ; I<=$N_RUNNING_COOLSTORES ; I++ ))
do
    oc new-project running-coolstore$I
done

for (( I=1 ; I<=$N_RUNNING_COOLSTORES ; I++ ))
do
    oc project running-coolstore$I
    oc process -f openshift/coolstore-template.yaml | oc create -f -
done