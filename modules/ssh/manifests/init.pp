class ssh {
    package { "openssh-server":
        ensure => installed
    }

    #Fix sshd config
    file { "/etc/ssh/sshd_config":
        source => "puppet:///modules/ssh/sshd_config",
        owner  => "root",
        group  => "root",
    }

    service { "ssh":
        enable    => true,
        ensure    => running,
        subscribe => File["/etc/ssh/sshd_config"],
		require   => Package["openssh-server"],
    }
    
    exec { "allow-openssh":
        command => "/usr/sbin/ufw allow OpenSSH",
        unless  => "/usr/sbin/ufw status | grep \"OpenSSH.*ALLOW.*Anywhere\\|Status: inactive\"",
        require => Exec["enable-firewall"],
    }
}