# modules/apache/manifests/site-config.pp
#
# Synopsis:
#       Installs a web site configuration file for the Apache HTTP server.
#
# Parameters:
#       NONE
#       Name__________  Default_______  Description___________________________
#
#       name                            name of the web site
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
#       apache::site-config { 'acme':
#           notify  => Service['httpd'],
#           source  => 'puppet:///private-host/acme.conf',
#       }

define apache::site-config ($ensure='present', $source) {

    file { "/etc/httpd/conf.d/${name}.conf":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_config_t',
        require => Package['httpd'],
        source  => "${source}",
    }

}
