#!/bin/bash

set -ex

declare -A dists=(
    ["precise"]="1.9.1 1.8 2.0 2.1 2.2 2.3"
    ["trusty"]="1.9.1 1.8 2.0 2.1 2.2 2.3"
    ["wily"]="2.0 2.1 2.2 2.3"
)

for dist in ${DIST_CODENAME:=${!dists[@]}} ; do
    docker run -i -e RUBY_VERSIONS="${dists[$dist]}" -e PPA_NAME=${PPA_NAME:="ppa:brightbox/ruby-ng-experimental"} ubuntu:${dist} bash < install-tests.sh
done
