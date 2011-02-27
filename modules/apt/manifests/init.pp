define apt::key($keyid, $ensure, $keyserver = "keyserver.ubuntu.com") {
    case $ensure {
        present: {
            exec { "Import $keyid to apt keystore":
                path        => "/bin:/usr/bin",
                environment => "HOME=/root",
                command     => "gpg --keyserver $keyserver --recv-keys $keyid && gpg --export --armor $keyid | apt-key add -",
                user        => "root",
                group       => "root",
                unless      => "apt-key list | grep $keyid",
                logoutput   => on_failure,
            }
        }
        absent:  {
            exec { "Remove $keyid from apt keystore":
                path        => "/bin:/usr/bin",
                environment => "HOME=/root",
                command     => "apt-key del $keyid",
                user        => "root",
                group   	=> "root",
                onlyif  	=> "apt-key list | grep $keyid",
            }
        }
        default: {
            fail "Invalid 'ensure' value '$ensure' for apt::key"
        }
    }
}

class apt {
    #Set sources for apt
    file { "/etc/apt/sources.list":
        source => "puppet:///modules/apt/sources.list",
        owner  => "root",
        group  => "root",
    }
    
    exec { "apt-get update":
        path        => ["/usr/bin"],
        subscribe 	=> File["/etc/apt/sources.list"],
        refreshonly => true,
    }
}
