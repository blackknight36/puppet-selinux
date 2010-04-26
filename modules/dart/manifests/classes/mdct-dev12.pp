# /etc/puppet/modules/dart/manifests/classes/mdct-dev12.pp

class dart::mdct-dev12 inherits dart::workstation_node {
    # passwords generated with bacula-password-generator package
    $bacula_client_director_password = "2hNcW1n2jkNU5ywm4TK6CrY2yDmqlEPcr2SoRP0abEHW"
    $bacula_client_director_monitor_password = "WqQvFNJdbiIfyxnKkoocVQFcNgY0CLVcKXok1TtrhJTH"
    include bacula_client

    include bacula_admin
    include mysql-server
    include yum-cron
}
