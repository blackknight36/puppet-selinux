# modules/MODULE_NAME/manifests/DEFINE_NAME.pp
#
# Synopsis:
#       Installs a DEFINE_NAME configuration file for MODULE_NAME.
#
# Parameters:
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

    file { "/CONFIG_PATH/${name}.conf":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'MODULE_NAME_config_t',
        require => Package['PACKAGE_NAME'],
        source  => "${source}",
    }

}
