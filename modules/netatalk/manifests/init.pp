class netatalk {
    package { netatalk:
        ensure => installed,
    }
    
    file { "/etc/ufw/applications.d/netatalk":
        source => "puppet:///modules/netatalk/netatalk.ufw",
		require => Package["ufw"],
        owner  => "root",
        group  => "root",
    }

    exec { "allow-netatalk":
        command => "/usr/sbin/ufw allow netatalk",
        unless  => "/usr/sbin/ufw status | grep \"netatalk.*ALLOW.*Anywhere\\|Status: inactive\"",
        require => [Exec["enable-firewall"], File["/etc/ufw/applications.d/netatalk"]],
    }
    
}