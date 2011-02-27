stage { pre: before => Stage[main] }

$rootdir = "/etc"

Package { require => Exec["apt-get update"] }

import "classes.pp"
import "nodes.pp"
