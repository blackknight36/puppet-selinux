# modules/apache/manifests/definitions/misc-config.pp
#
# Synopsis:
#       Installs a miscellaneous configuration file for the Apache HTTP
#       server.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       name                            name of the configuration file
#       ensure          present         instance is to be present/absent
#       source                          puppet URI to the configuration file
#
# Requires:
#       Class['apache']
#
# Example usage:
#
#       include 'apache'
#
#       apache::misc-config { 'dav_auth':
#           notify  => Service['apache'],
#           source  => 'puppet:///private-host/dav_auth',
#       }


define apache::misc-config ($ensure='present', $source) {

    file { "/etc/httpd/${name}":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'apache',
        mode    => '0640',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_config_t',
        require => Package['httpd'],
        source  => "${source}",
    }

}
