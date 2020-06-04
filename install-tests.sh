#!/bin/bash

declare -a versions=(${RUBY_VERSIONS="1.9.1 1.8 2.0 2.1 2.2 2.3 2.4 2.5"})
defaultver=${RUBY_DEFAULT_VERSION:=${versions[0]}}

echo "============ install-tests.sh: Testing ${PPA_NAME} for ruby versions: ${versions[*]} with default version ${defaultver}"

export TERM=ansi
export DEBIAN_FRONTEND=noninteractive

function package_to_ruby_version {
    if [ "$1" == "1.9.1" ] ; then
        echo "1.9.3"
    else
        echo $1
    fi
}


set -ex

apt-get update -qqy
apt-get install -qqy --no-install-recommends software-properties-common >/dev/null
apt-get install -qqy --no-install-recommends build-essential zlib1g-dev libxml2-dev libxslt-dev >/dev/null

yes | apt-add-repository ${PPA_NAME}

apt-get update -qqy

echo "============ install each version on it's own"
for ver in ${versions[*]} ; do
    apt-cache madison ruby${ver} | grep bbox
    apt-get install -q -y --no-install-recommends ruby${ver}
    dpkg -l ruby${ver} | grep bbox
    ruby -v
    # the default ruby should become this version
    ruby -v | grep -E "ruby $(package_to_ruby_version $ver)"
    gem -v
    ruby${ver} -v
    gem${ver} -v
    gem${ver} install -v 5.11.3 minitest
    # make sure the gem was installed in the right place
    test -d /var/lib/gems/${ver}*/gems/minitest-*
    apt-get install -q -y --no-install-recommends ruby${ver}-dev
    # nokogiri 1.5.11 still works on 1.8
    gem${ver} install --version 1.5.11 nokogiri
    apt-get remove -q -y ruby${ver} ruby${ver}-dev rake ruby-test-unit
done

echo "============ install all versions together"
for ver in ${versions[*]} ; do
    apt-get install -q -y --no-install-recommends ruby${ver} ruby${ver}-dev
    dpkg -l ruby${ver} | grep bbox
    ruby -v
    # the default ruby shouldn't change as we install new packages
    ruby -v | grep -E "ruby $(package_to_ruby_version $defaultver)"
    gem -v
    ruby${ver} -v
    gem${ver} -v

    # make sure the gem was installed in the right place
    test -d /var/lib/gems/${ver}*/gems/nokogiri-*

    ruby${ver} -r rbconfig -e "exit RbConfig::CONFIG['sysconfdir'] == '/etc'"
done

apt-get install -q -y --no-install-recommends ruby-switch

echo "============ switch between versions"
for ver in ${versions[*]} ; do
    ruby-switch --set ruby${ver}
    ruby -v
    ruby -v | grep "ruby $(package_to_ruby_version $ver)"
done

# Test ruby-switch again after installing ruby package
echo "============ switch between versions with ruby package installed"
apt-get install -q -y --no-install-recommends ruby

for ver in ${versions[*]} ; do
    ruby-switch --set ruby${ver}
    ruby -v
    ruby -v | grep "ruby $(package_to_ruby_version $ver)"
done

echo "finished successfully"
