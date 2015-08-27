#!/bin/bash

set -ex

for codename in precise trusty utopic vivid ; do
	docker run -i -e PPA_NAME=ppa:brightbox/ruby-ng-experimental ubuntu:$codename sh < install-tests.sh
done
