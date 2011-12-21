# modules/MODULE_NAME/manifests/definitions/DEFINE_NAME.pp
#
# Synopsis:
#       Installs a web-site configuration file for the Apache web server.
#
# Parameters:
#       NONE
#       Name__________  Default_______  Description___________________________
#
#       name                            instance name
#       ensure          present         instance is to be present/absent
#
# Requires:
#       Class['MODULE_NAME']
#
# Example usage:
#
#       include MODULE_NAME
#
#       MODULE_NAME::DEFINE_NAME { 'acme':
#           notify  => Service['SERVICE_NAME'],
#           source  => 'puppet:///private-host/acme.conf',
#       }


define MODULE_NAME::DEFINE_NAME ($ensure='present', $source) {

    file { "/CONFIG_PATH/conf.d/${name}.conf":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_config_t',
        require => Package['PACKAGE_NAME'],
        source  => "${source}",
    }

}
