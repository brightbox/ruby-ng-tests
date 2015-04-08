#!/bin/bash

set -ex

apt-get update -qqy
which apt-add-repository || apt-get install -qqy --no-install-recommends software-properties-common || true
which apt-add-repository || apt-get install -qqy --no-install-recommends  python-software-properties || true

yes | apt-add-repository ${PPA_NAME}

apt-get update

# Utopic doesn't have 1.8 packages yet
if (lsb_release -c | grep -qv utopic) ; then
    apt-get install -y --no-install-recommends ruby1.8 rubygems1.8
    ruby -v | grep -E "1.8.*Ruby Enterprise Edition"
    gem -v
    ruby1.8 -v
    gem1.8 -v
    gem install minitest
fi

apt-get install -y --no-install-recommends ruby1.9.3
ruby -v | grep -E "1.9.3.*Brightbox"
gem -v
ruby1.9.1 -v
ruby1.9.3 -v
gem1.9.1 -v
gem1.9.3 -v
gem1.9.3 install minitest

apt-get install -y --no-install-recommends ruby2.0
ruby -v | grep 1.9
gem -v
ruby2.0 -v
gem2.0 -v
gem2.0 install minitest

# Lucid doesn't have ruby2.1 or ruby 2.2
if (lsb_release -c | grep -qv lucid) ; then
    apt-get install -y --no-install-recommends ruby2.1
    ruby -v | grep 1.9
    gem -v
    ruby2.1 -v
    gem2.1 -v
    gem2.1 install minitest

    apt-get install -y --no-install-recommends ruby2.2
    ruby -v | grep 1.9
    gem -v
    ruby2.2 -v
    gem2.2 -v
    gem2.2 install minitest
fi

apt-get install -y --no-install-recommends ruby-switch

if (lsb_release -c | grep -qv utopic) ; then
    ruby-switch --set ruby1.8
    ruby -v | grep 1.8
fi
ruby-switch --set ruby1.9.1
ruby -v | grep 1.9
ruby-switch --set ruby2.0
ruby -v | grep 2.0
if (lsb_release -c | grep -qv lucid) ; then
    ruby-switch --set ruby2.1
    ruby -v | grep 2.1
    ruby-switch --set ruby2.2
    ruby -v | grep 2.2
fi
