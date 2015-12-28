#!/bin/bash

set -ex

declare -A dists=(
    ["precise"]="1.9.1 1.8 2.0 2.1 2.2"
    ["trusty"]="1.9.1 1.8 2.0 2.1 2.2"
    ["vivid"]="1.9.1 2.0 2.1 2.2"
    ["wily"]="2.0 2.1 2.2"
)

for dist in ${!dists[@]} ; do
    docker run -i -e RUBY_VERSIONS="${dists[$dist]}" -e PPA_NAME=${PPA_NAME:="ppa:brightbox/ruby-ng-experimental"} ubuntu:${dist} bash < install-tests.sh
done
