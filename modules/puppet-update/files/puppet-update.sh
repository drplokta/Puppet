#!/bin/bash
cd /etc/puppet
/usr/bin/git pull origin master
/usr/bin/puppet apply --confdir=/etc/puppet /etc/puppet/manifests/site.pp