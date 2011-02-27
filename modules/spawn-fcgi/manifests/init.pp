class spawn-fcgi {
    package { "spawn-fcgi":
        ensure => installed,
    }
    
    package { "php-fastcgi":
        provider => dpkg,
        ensure   => latest,
        source   => "${rootdir}/puppet/modules/spawn-fcgi/files/php-fastcgi_0.1-1_all.deb",
        require  => Package["spawn-fcgi","php5-cgi"],
    }

    file { "/etc/default/php-fastcgi":
        source => "puppet:///modules/spawn-fcgi/php-fastcgi",
        owner  => "root",
        group  => "root",
    }

    service { "php-fastcgi":
        ensure     => running,
        hasstatus  => true,
		hasrestart => true,
        subscribe  => File["/etc/default/php-fastcgi"],
		require    => Package["php-fastcgi"],
    }
}
