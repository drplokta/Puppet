class puppet-update {
    package { ["puppet"]:
        ensure => installed,
    }

    #Apply changes every five minutes
    file    { "/root/puppet-update.sh":
        source  => "puppet:///modules/puppet-update/puppet-update.sh",
        owner   => "root",
        group   => "root",
        mode    => "755",
        require => Package["puppet","git"],
    }

    cron { "puppet-update":
        command => "/root/puppet-update.sh > /dev/null 2>&1",
        user    => "root",
        minute  => [0,5,10,15,20,25,30,35,40,45,50,55],
    }
}

