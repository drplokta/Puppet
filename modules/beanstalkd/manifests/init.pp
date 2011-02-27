class beanstalkd {
    package { "beanstalkd":
        ensure => installed,
    }
    
    file { "/etc/default/beanstalkd":
        source => "puppet:///modules/beanstalkd/beanstalkd",
        owner  => "root",
        group  => "root",
        notify => Service["ufw"],
    }
    
    file { "/etc/ufw/applications.d/beanstalkd":
        source  => "puppet:///modules/beanstalkd/beanstalkd.ufw",
		require => Package["ufw"],
        owner  => "root",
        group  => "root",
    }

    exec { "allow-beanstalkd":
        command => "/usr/sbin/ufw allow beanstalkd",
        unless  => "/usr/sbin/ufw status | grep \"beanstalkd.*ALLOW.*Anywhere\\|Status: inactive\"",
        require => [Exec["enable-firewall"], File["/etc/ufw/applications.d/beanstalkd"]],
    }
    
    service { "beanstalkd":
        ensure     => running,
        subscribe  => File["/etc/default/beanstalkd"],
        hasstatus  => true,
        hasrestart => true,
        require    => Package["beanstalkd"],
    }
}