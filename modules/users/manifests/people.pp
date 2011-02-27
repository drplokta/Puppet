class users::people {
	@useraccount { "mikes":
        ensure   => present,
        pgroup   => "adm",
        fullname => "Mike Scott",
        uid      => "1000",
        shell    => "/bin/bash",
        groups   => ["users"],
	}
}
