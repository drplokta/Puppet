class users {
	define useraccount ( $ensure = present, $uid, $pgroup = users,
                       $groups, $fullname, $homefs = "/home", $shell) {
        $username = $name
    	# This case statement will allow disabling an account by passing
    	# ensure => absent, to set the home directory ownership to root.
    	case $ensure {
        	present: {
            	$home_owner = $username
            	$home_group = $pgroup
        	}
        	default: {
            	$home_owner = "root"
            	$home_group = "root"
        	}
    	}
    	# Create the user with their groups as specified
    	user { $username:
        	ensure    => $ensure,
        	uid       => $uid,
        	gid       => $pgroup,
        	groups    => $groups,
        	comment   => $fullname,
        	home      => "${homefs}/$username",
        	shell     => $shell,
        	allowdupe => false,
    	}
    	file { "${homefs}/${username}":
        	ensure  => directory,
        	owner   => $home_owner,
        	group   => $home_group,
        	mode    => "755",
        	require => User["${username}"],
    	}
    	file { "${homefs}/${username}/.ssh":
        	ensure  => directory,
        	owner   => $home_owner,
        	group   => $home_group,
        	mode    => "700",
        	require => File["${homefs}/${username}"],
    	}
    	file { "${homefs}/${username}/.ssh/authorized_keys":
        	ensure  => present,
        	owner   => $home_owner,
        	group   => $home_group,
        	mode    => "600",
        	require => File["${homefs}/${username}/.ssh"],
        	source  => "puppet:///modules/users/${username}/ssh/authorized_keys",
    	}
	}
}

class users::admin {
	realize Useraccount["mikes"]
#    Useraccount <| pgroup == adm |>
}

