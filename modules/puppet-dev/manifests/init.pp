class puppet-dev {
    package { ["dh-make-php", ]:
        ensure => installed,
    }
}