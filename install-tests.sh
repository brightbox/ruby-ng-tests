#!/bin/bash


declare -a versions=(${RUBY_VERSIONS="2.0 2.1 2.2"})
defaultver=${RUBY_DEFAULT_VERSION:=${versions[0]}}

echo "============ install-tests.sh: Testing ${PPA_NAME} for ruby versions: ${versions[*]} with default version ${defaultver}"

export TERM=ansi
export DEBIAN_FRONTEND=noninteractive

set -ex

apt-get update -qqy
which apt-add-repository || apt-get install -qqy --no-install-recommends software-properties-common >/dev/null || true
which apt-add-repository || apt-get install -qqy --no-install-recommends python-software-properties >/dev/null || true
apt-get install -qqy --no-install-recommends build-essential zlib1g-dev >/dev/null

yes | apt-add-repository ${PPA_NAME}

apt-get update -qqy

for ver in ${versions[*]} ; do
    apt-cache madison ruby${ver} | grep bbox
    apt-get install -q -y --no-install-recommends ruby${ver}
    dpkg -l ruby${ver} | grep bbox
    ruby -v
    ruby -v | grep -E ${defaultver:0:3}
    if [ "${ver}" == "1.8" ] ; then
        apt-get install -q -y --no-install-recommends rubygems rubygems1.8
    fi
    gem -v
    ruby${ver} -v
    gem${ver} -v
    gem${ver} install minitest
    apt-get install -q -y --no-install-recommends ruby${ver}-dev
    gem${ver} install nokogiri
done

apt-get install -y --no-install-recommends ruby-switch

for rubyver in $RUBY_VERSIONS ; do
    ruby-switch --set ruby${rubyver}
    ruby -v
    ruby -v | grep ${rubyver:0:3}
done
