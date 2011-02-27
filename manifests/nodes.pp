node "dev1.localdomain" {
    include standard
    include webserver
    include mongodbserver
    include postgresqlserver
    include dev
}

node "int1.localdomain" {
    include standard
    include integrationserver
    include mongodbserver
    include webserver
    include postgresqlserver
}
