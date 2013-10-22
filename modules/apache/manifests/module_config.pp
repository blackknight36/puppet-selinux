# modules/apache/manifests/module_config.pp
#
# Synopsis:
#       Installs a module configuration file for the Apache HTTP server.
#
# Parameters:
#       Name__________  Notes_  Description___________________________________
#
#       name            1       instance name, e.g., "99-prefork"
#
#       ensure          2       instance is to be present/absent
#
#       source          3       URI of file content
#
#       content         3       literal file content
#
# Notes:
#
#       1. Include neither path, nor '.conf' extension.  These typically have
#       a two-digit prefix for priority sequencing.
#
#       2. Default is 'present'.
#
#       3. Default is undef.  Either the source parameter or the content
#       parameter must be specified.  The other should be left at its default.
#
# Requires:
#       Class['apache']


define apache::module_config (
        $ensure='present', $source=undef, $content=undef
    ) {

    include 'apache::params'

    File {
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_config_t',
        require => Package[$apache::params::packages],
        before  => Service[$apache::params::service_name],
        notify  => Service[$apache::params::service_name],
    }

    if $source != undef {
        file { "/etc/httpd/conf.modules.d/${name}.conf":
            source  => "${source}",
        }
    } elsif $content != undef {
        file { "/etc/httpd/conf.modules.d/${name}.conf":
            content => "${content}",
        }
    } else {
        fail ('One of $source or $content is required.')
    }

}
