# /etc/puppet/manifests/nodes.pp

################################################################################
#                                 Node Types
################################################################################

node "base_node" {
    include authconfig
    include autofs
    # include cups
    # include local-mounts
    include nscd
    include ntp
    include openssh-server
    include pam
    include pkgs_base
    # include postfix-client
    include puppet
    include rpcidmapd
    include storage-relocation
    include sudo
    # include unwanted-services
}


node "server_node" inherits "base_node" {
    include pkgs_net_tools
}


node "workstation_node" inherits "base_node" {
    include lotus_notes_client
    include pkgs_developer
    include pkgs_media
    include pkgs_net_tools
    include pkgs_virtualization
    include pkgs_workstation
}


node "build_server_node" inherits "server_node" {
    include pkgs_developer
    include pkgs_net_tools
}


node "puppet_server_node" inherits "server_node" {
    include pkgs_developer
    include puppet-server
    include yum-cron
}


################################################################################
#                                Actual Nodes
################################################################################

node "mdct-00dw.dartcontainer.com" inherits "server_node" {
}

node "mdct-dev6.dartcontainer.com" inherits "workstation_node" {
}


node "mdct-dev9.dartcontainer.com" inherits "workstation_node" {
}


node "mdct-dev12.dartcontainer.com" inherits "workstation_node" {
    # passwords generated with bacula-password-generator package
    $bacula_client_director_password = "2hNcW1n2jkNU5ywm4TK6CrY2yDmqlEPcr2SoRP0abEHW"
    $bacula_client_director_monitor_password = "WqQvFNJdbiIfyxnKkoocVQFcNgY0CLVcKXok1TtrhJTH"
    include bacula_client

    include bacula_admin
    include mysql-server
    include yum-cron
}


node "mdct-dev13.dartcontainer.com" inherits "base_node" {
    include pkgs_workstation
}


node "mdct-f8-builder.dartcontainer.com" inherits "build_server_node" {
    include yum-cron
}


node "mdct-f10-builder.dartcontainer.com" inherits "build_server_node" {
    include yum-cron
}


node "mdct-f12-builder.dartcontainer.com" inherits "build_server_node" {
    include yum-cron
}


node "mdct-puppet.dartcontainer.com" inherits "puppet_server_node" {
    # passwords generated with bacula-password-generator package
    $bacula_client_director_password = "0cCamrzZiiA5mOHh3YkffFoymLroVOTU1wr2nmLEPKae"
    $bacula_client_director_monitor_password = "kPn3DRuaxk9Iwchm0mq4WthqYdwXbI4QI9WLArP3S4nz"
    include bacula_client
}


node "mdct-test-agent-32.dartcontainer.com" inherits "server_node" {
}

node "mole.dartcontainer.com" inherits "workstation_node" {
}

