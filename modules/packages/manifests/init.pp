class packages {
    package { ["sudo","screen","unzip"]:
        ensure => installed,
    }
}
