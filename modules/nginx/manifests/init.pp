class nginx {
    package { "nginx":
        ensure  => installed,
		require => Package["apache2-mpm-prefork", "apache2.2-bin", "apache2.2-common", "apache2-utils", "apache2-mpm-itk"],
    }
    
    package { ["apache2-mpm-prefork", "apache2.2-bin", "apache2.2-common", "apache2-utils", "apache2-mpm-itk"]:
        ensure => absent,
    }

    file { "/etc/nginx/sites-available/default":
        source  => "puppet:///modules/nginx/default",
        owner   => "root",
        group   => "root",
		require => Package["nginx"],
    }

    service { "nginx":
        ensure     => running,
        hasrestart => true,
        hasstatus  => true,
        subscribe  => File["/etc/nginx/sites-available/default"],
		require    => Package["nginx"],
    }
    
    file { "/etc/ufw/applications.d/nginx-server":
        source => "puppet:///modules/ufw/nginx-server",
		require => Package["ufw"],
        owner  => "root",
        group  => "root",
    }

    exec { "allow-http":
        command => "/usr/sbin/ufw allow nginx",
        unless  => "/usr/sbin/ufw status | grep \"nginx.*ALLOW.*Anywhere\\|Status: inactive\"",
        require => [Exec["enable-firewall"], File["/etc/ufw/applications.d/nginx-server"]],
    }
}
