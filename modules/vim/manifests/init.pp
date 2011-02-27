class vim {
    package { "vim":
        ensure => installed,
    }

    #Set default editor
    exec { "update-alternatives --set editor /usr/bin/vim.basic":
        path    => "/bin:/sbin:/usr/bin:/usr/sbin",
        unless  => "test /etc/alternatives/editor -ef /usr/bin/vim.basic",
        require => Package["vim"],
    }
}
