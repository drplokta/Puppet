class postgresql {
    package { ["postgresql-9.0", "postgresql-client-9.0"]:
        ensure  => installed,
		require => File["/etc/apt/preferences.d/postgresql.pref"],
    }
    
    file { "/etc/ufw/applications.d/postgresql-server":
        source => "puppet:///modules/ufw/postgresql-server",
		require => Package["ufw"],
        owner  => "root",
        group  => "root",
    }

    file { "/etc/apt/preferences.d/postgresql.pref":
        source => "puppet:///modules/postgresql/postgresql.pref",
        owner  => "root",
        group  => "root",
    }

    exec { "allow-postgresql":
        command => "/usr/sbin/ufw allow PostgreSQL",
        unless  => "/usr/sbin/ufw status | grep \"PostgreSQL.*ALLOW.*Anywhere\\|Status: inactive\"",
        require => [Exec["enable-firewall"], File["/etc/ufw/applications.d/postgresql-server"]],
    }
    
}