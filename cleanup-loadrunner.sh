#!/usr/bin/env bash

oc get project | grep running-coolstore | awk '{print $1}' | xargs oc delete project
oc get project | grep building-coolstore | awk '{print $1}' | xargs oc delete project
oc get project | grep running-postgres | awk '{print $1}' | xargs oc delete project





