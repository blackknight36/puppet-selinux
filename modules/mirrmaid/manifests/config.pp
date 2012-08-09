# modules/mirrmaid/manifests/config.pp
#
# Synopsis:
#       Installs a mirrmaid configuration file.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       name                            instance name
#
#       ensure          present         instance is to be present/absent
#
#       source                          URI of the mirrmaid configuration file
#                                       to be installed.


define mirrmaid::config ($ensure='present', $source) {

    file { "/etc/mirrmaid/${name}.conf":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'mirrmaid',
        mode    => '0644',
        require => Package['mirrmaid'],
        source  => "${source}",
    }

}
