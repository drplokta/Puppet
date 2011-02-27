class jenkins {
    Package { require => File["/etc/pear/pear.conf"] }
    
	include apt
	include ufw
	
    package { "jenkins":
        ensure  => installed,
    }
    
    package { "PHP_Depend":
        ensure   => installed,
        provider => pear,
        source   => "pear.pdepend.org/PHP_Depend",
    }
    
    package { "PHP_PMD":
        ensure   => installed,
        provider => pear,
        source   => "pear.phpmd.org/PHP_PMD",
    }
    
    package { "php5-curl":
        ensure => installed,
    }

    package { "XML_RPC2":
        ensure   => installed,
        provider => pear,
        require  => Package["php5-curl"],
    }    
    
    package { "PHPUnit":
        ensure   => installed,
        provider => pear,
        source   => "pear.phpunit.de/PHPUnit",
        require  => Package["XML_RPC2"],
    }    
    
    package { "phpcpd":
        ensure   => installed,
        provider => pear,
        source   => "pear.phpunit.de/phpcpd",
    }    
    
    package { "phploc":
        ensure   => installed,
        provider => pear,
        source   => "pear.phpunit.de/phploc",
    }    
    
    package { "PhpDocumentor":
        ensure   => installed,
        provider => pear,
    }    
    
    package { "PHP_CodeSniffer":
        ensure   => installed,
        provider => pear,
    }    
    
    file { "/etc/pear/pear.conf":
        source => "puppet:///modules/jenkins/pear.conf",
        owner  => "root",
        group  => "root",
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