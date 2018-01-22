#!/bin/bash

set -e

info() { 
	echo "$@" 1>&2; 
}

info Building images
for f in {1..5}; do
    cd $f
    for d in Dockerfile*; do
        if [[ -f $d ]]; then
            info Building local-reg:5000/devconf/c$f$tag
            tag=${d#Dockerfile}
            docker build . -t local-reg:5000/devconf/c$f$tag
            docker push local-reg:5000/devconf/c$f$tag
        fi
    done
    cd - 
done

