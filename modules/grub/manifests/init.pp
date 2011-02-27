class grub {
    # disable IPV6
    package { "grub":
        ensure => installed,
    }

    file { "/etc/default/grub":
        source => "puppet:///modules/grub/grub",
        owner  => "root",
        group  => "root",
    }

    exec { "/usr/sbin/update-grub":
        subscribe   => File["/etc/default/grub"],
        refreshonly => true,
    }
}
