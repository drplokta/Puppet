class git {
    package { ["git", "git-svn"]:
        ensure => installed,
    }
}