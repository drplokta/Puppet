class jenkins {
	include apt
	include ufw
	
    package { "jenkins":
        ensure  => installed,
    }
    
    file { "/etc/ufw/applications.d/jenkins":
        source  => "puppet:///modules/jenkins/jenkins.ufw",
		require => Package["ufw"],
        owner   => "root",
        group   => "root",
    }

    exec { "allow-jenkins":
        command => "/usr/sbin/ufw allow \"Jenkins\"",
        unless  => "/usr/sbin/ufw status | grep \"Jenkins.*ALLOW.*Anywhere\\|Status: inactive\"",
        require => [Exec["enable-firewall"], File["/etc/ufw/applications.d/jenkins"]],
    }

	file { "/etc/apt/sources.list.d/jenkins.list":
    	source  => "puppet:///modules/jenkins/jenkins.list",
        owner   => "root",
        group   => "root",
		notify  => Exec["apt-get update"], 
		before  => Exec["apt-get update"], 
	}
	
	#Apt key for Jenkins
    apt::key { "D50582E6":
        keyid  => "D50582E6",
        ensure => present,
		notify  => Exec["apt-get update"], 
		before  => Exec["apt-get update"], 
    }
}