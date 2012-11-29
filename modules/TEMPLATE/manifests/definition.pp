# modules/MODULE_NAME/manifests/DEFINE_NAME.pp
#
# Synopsis:
#       Installs a DEFINE_NAME configuration file for MODULE_NAME.
#
# Parameters:
#       Name__________  Notes_  Description___________________________________
#
#       name                    instance name
#
#       ensure          1       instance is to be present/absent
#
# Notes:
#
#       1. Default is 'present'.


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
