class postgresql {
    include apt
    
    package { ["postgresql-9.0", "postgresql-client-9.0"]:
        ensure  => installed,
    }
    
    file { "/etc/ufw/applications.d/postgresql-server":
        source => "puppet:///modules/postgresql/postgresql-server.ufw",
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
        command => "/usr/sbin/ufw allow from $::network_eth0/$::netmask_eth0 to any app PostgreSQL",
        unless  => "/usr/sbin/ufw status | grep \"PostgreSQL.*ALLOW\\|Status: inactive\"",
        require => [Exec["enable-firewall"], File["/etc/ufw/applications.d/postgresql-server"]],
    }
    
}