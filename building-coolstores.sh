#!/usr/bin/env bash

# this is the number of coolstores we want to build simultaneously
N_BUILDING_COOLSTORES=3
# This is the max number in seconds before triggering a new build
# or deleting a project
INTERVAL=300

git clone https://github.com/jbossdemocentral/coolstore-microservice || true

cd coolstore-microservice
git pull

while true
do
    for (( I=1 ; I<=$N_BUILDING_COOLSTORES ; I++ ))
    do
        oc new-project running-coolstore$I
    done

    for (( I=1 ; I<=$N_RUNNING_COOLSTORES ; I++ ))
    do
        oc project running-coolstore$I
        oc process -f openshift/coolstore-template.yaml | oc create -f -
        SLEEP=$RANDOM
        let "SLEEP %= $INTERVAL"
        sleep $SLEEP
    done

# clear up
    for (( I=1 ; I<=$N_RUNNING_COOLSTORES ; I++ ))
    do
        oc delete project running-coolstore$I
        SLEEP=$RANDOM
        let "SLEEP %= $INTERVAL"
        sleep $SLEEP
    done
done
