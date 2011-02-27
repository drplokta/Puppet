class ufw {
    package { "ufw":
        ensure => installed,
    }
    
    exec { "enable-firewall":
      command => "/usr/bin/yes | /usr/sbin/ufw enable",
      unless  => "/usr/sbin/ufw status | grep \"Status: active\"",
      require => [Package["ufw"]],
    }
    
    service { "ufw":
        require    => Package["ufw"],
        hasrestart => true,
        hasstatus  => true,
    }
}