# /etc/puppet/modules/dart/manifests/classes/mdct-puppet.pp

class dart::mdct-puppet inherits dart::puppet_server_node {
    # passwords generated with bacula-password-generator package
    $bacula_client_director_password = "0cCamrzZiiA5mOHh3YkffFoymLroVOTU1wr2nmLEPKae"
    $bacula_client_director_monitor_password = "kPn3DRuaxk9Iwchm0mq4WthqYdwXbI4QI9WLArP3S4nz"
    #include bacula::client
}
