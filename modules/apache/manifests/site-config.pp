# modules/apache/manifests/site-config.pp
#
# Synopsis:
#       Installs a site configuration file for the Apache HTTP server.
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
#       apache::site-config { 'acme':
#           source  => 'puppet:///private-host/acme.conf',
#       }


define apache::site-config ($ensure='present', $source) {

    include 'apache::params'

    file { "/etc/httpd/conf.d/${name}.conf":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
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
