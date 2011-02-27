class packages {
    package { ["sudo","screen","unzip"]:
        ensure => installed,
        require => Exec["apt-get update"],
    }
}
