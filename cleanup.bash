#!/bin/bash

for u in {1..10}; do
    oc delete project devconf$u-project
    oc delete user devconf$u
    userdel devconf$u
    rm -rf /home/devconf$u
done
