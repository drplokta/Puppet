class exim4 {
    package { "exim4":
        ensure => installed,
    }

    file { "/etc/exim4/update-exim4.conf.conf":
        source => "puppet:///modules/exim4/update-exim4.conf.conf",
        owner  => "root",
        group  => "root",
    }

    service { "exim4":
        ensure    => running,
        subscribe => File["/etc/exim4/update-exim4.conf.conf"],
        require   => Package["exim4"],
    }
}
