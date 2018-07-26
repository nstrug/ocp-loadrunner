#!/usr/bin/env bash

set -x
# Loadrunner to test creation and deletion of persistent volumes

# this is the number of running postgres databases we want to deploy
N_RUNNING_POSTGRES=10
# This is the max number in seconds before triggering a new deployment
# or deleting a project
INTERVAL=300

# Need to ensure there is a default storage class with:
# oc patch storageclass glusterfs-storage -p '{"metadata": {"annotations": {"storageclass.kubernetes.io/is-default-class": "true"}}}'

oc new-project pv-loadrunner

while true
do
    for (( I=1 ; I<=$N_RUNNING_POSTGRES ; I++ ))
    do
        oc new-project running-postgres$I
    done

    for (( I=1 ; I<=$N_RUNNING_POSTGRES; I++ ))
    do
        oc project running-postgres$I
        oc new-app postgresql-persistent
        SLEEP=$RANDOM
        let "SLEEP %= $INTERVAL"
        sleep $SLEEP
    done

# clear up
    for (( I=1 ; I<=$N_RUNNING_POSTGRES ; I++ ))
    do
        oc delete project running-postgres$I
        SLEEP=$RANDOM
        let "SLEEP %= $INTERVAL"
        sleep $SLEEP
    done
done
