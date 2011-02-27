stage { pre: before => Stage[main] }

$rootdir = "/etc"

#Make apt-get update run before installing packages
Package { require => Exec["apt-get update"] }

include apt
include ufw
include git

import "classes.pp"
import "nodes.pp"
