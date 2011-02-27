class standard {
	include packages
    include grub
    include ssh
	include puppet-update
	include users
	include users::people
	include users::admin
	include vim
    include exim4
}

class webserver {
    include nginx
    include spawn-fcgi
    include php5
    include beanstalkd
    include memcached
    include jenkins
}

class mongodbserver {
    include mongodb
}

class postgresqlserver {
    include postgresql
}

class dev {
    include mongodb::dev
	include netatalk
	include jenkins
}

class integrationserver {
    include jenkins
}
