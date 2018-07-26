#!/usr/bin/env bash

# This is the master loadrunner which starts all loads

./running-coolstores.sh &

./building-coolstores.sh &

./pv-operations.sh &
