class memcached {
    package { ["memcached", "php5-memcache"]:
        ensure => installed,
    }
}