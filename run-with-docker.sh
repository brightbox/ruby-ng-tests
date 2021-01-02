#!/bin/bash

set -ex

declare -A dists=(
    ["xenial"]="1.9.1 1.8 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7"
    ["bionic"]="2.3 2.4 2.5 2.6 2.7"
    ["focal"]="2.6 2.7"
)

for dist in ${DIST_CODENAME:=${!dists[@]}} ; do
    docker run -i -e RUBY_VERSIONS="${dists[$dist]}" -e PPA_NAME=${PPA_NAME:="ppa:brightbox/ruby-ng-experimental"} ubuntu:${dist} bash < install-tests.sh
done
