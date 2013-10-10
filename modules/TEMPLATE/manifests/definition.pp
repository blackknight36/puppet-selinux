# modules/MODULE_NAME/manifests/DEFINE_NAME.pp
#
# Synopsis:
#       Installs a DEFINE_NAME configuration file for MODULE_NAME.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       ensure          1       instance is to be present/absent
#
#       source                  URI of file content
#
# Notes:
#
#       1. Default is 'present'.


define MODULE_NAME::DEFINE_NAME ($ensure='present', $source) {

    include 'MODULE_NAME::params'

    file { "/CONFIG_PATH/${name}.conf":
        ensure      => $ensure,
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'MODULE_NAME_config_t',
        before      => Service[$MODULE_NAME::params::service_name],
        notify      => Service[$MODULE_NAME::params::service_name],
        subscribe   => Package[$MODULE_NAME::params::packages],
        source      => $source,
    }

}
