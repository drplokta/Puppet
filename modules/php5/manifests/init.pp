class php5 {
    package { [
            "php5-cgi", "php-apc", "php-pear", "php5-cli",
            "php5-suhosin", "php5-xdebug", "php5-pgsql",
            "php5-gd", "php5-mcrypt", "php5-dev",
	]:
        ensure  => installed,
        notify  => Service["php-fastcgi"],
    }
    
    package { "mongo":
        provider => pecl,
        ensure   => installed,
        require  => Package["php5-dev"],
    }
}
