# modules/apache/manifests/misc_config.pp
#
# Synopsis:
#       Installs a miscellaneous configuration file for the Apache HTTP server.
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
# Example Usage:
#
#       include 'apache'
#
#       apache::misc_config { 'dav_auth':
#           source  => 'puppet:///private-host/dav_auth',
#       }


define apache::misc_config ($ensure='present', $source) {

    include 'apache::params'

    file { "/etc/httpd/${name}":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'apache',
        mode    => '0640',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_config_t',
        source  => "${source}",
        require => Package[$apache::params::packages],
        before  => Service[$apache::params::service_name],
        notify  => Service[$apache::params::service_name],
    }

}
