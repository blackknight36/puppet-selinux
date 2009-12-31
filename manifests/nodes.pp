# /etc/puppet/manifests/nodes.pp

node "base_node" {
    include authconfig
    include autofs
    # include cups
    # include local-mounts
    include openssh-server
    include nscd
    include ntp
    # include postfix-client
    include pkgs_base
    include puppet
    include rpcidmapd
    include sudo
    # include unwanted-services
}


node "server_node" inherits "base_node" {
    include pkgs_net_tools
}


node "workstation_node" inherits "base_node" {
    include pkgs_developer
    include pkgs_media
    include pkgs_net_tools
    include pkgs_workstation
}


node "build_server_node" inherits "server_node" {
    include pkgs_developer
    include pkgs_net_tools
}


node "mdct-dev6.dartcontainer.com" inherits "workstation_node" {
}


node "mdct-dev12.dartcontainer.com" inherits "workstation_node" {
    # passwords generated with bacula-password-generator
    $bacula_client_director_password = "2hNcW1n2jkNU5ywm4TK6CrY2yDmqlEPcr2SoRP0abEHW"
    $bacula_client_director_monitor_password = "WqQvFNJdbiIfyxnKkoocVQFcNgY0CLVcKXok1TtrhJTH"
    include bacula_client

    include bacula_admin
    include yum-cron
}


node "mdct-f8-builder.dartcontainer.com" inherits "build_server_node" {
    include yum-cron
}


node "mdct-f12-builder.dartcontainer.com" inherits "build_server_node" {
    include yum-cron
}


node "mdct-puppet.dartcontainer.com" inherits "server_node" {
    # passwords generated with bacula-password-generator
    $bacula_client_director_password = "0cCamrzZiiA5mOHh3YkffFoymLroVOTU1wr2nmLEPKae"
    $bacula_client_director_monitor_password = "kPn3DRuaxk9Iwchm0mq4WthqYdwXbI4QI9WLArP3S4nz"
    include bacula_client
    include yum-cron
}


