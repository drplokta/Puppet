class java {
    package { "sun-java6-jre":
        ensure 		 => installed,
        require      => File["/var/cache/debconf/jre6.seeds"],
        responsefile => "/var/cache/debconf/jre6.seeds",
    }
    
    file { "/var/cache/debconf/jre6.seeds":
        source => "puppet:///modules/java/jre6.seeds",
        owner  => "root",
        group  => "root",
    }
}
