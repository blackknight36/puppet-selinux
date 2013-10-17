# modules/apache/manifests/site-config.pp
#
# Synopsis:
#       Installs a site configuration file for the Apache HTTP server.
#
# Parameters:
#       Name__________  Notes_  Description___________________________________
#
#       name            1       instance name
#
#       ensure          2       instance is to be present/absent
#
#       source          3       URI of file content
#
#       content         3       literal file content
#
# Notes:
#
#       1. Include neither path, nor '.conf' extension.
#
#       2. Default is 'present'.
#
#       3. Default is undef.  Either the source parameter or the content
#       parameter must be specified.  The other should be left at its default.
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


define apache::site-config ($ensure='present', $source=undef, $content=undef) {

    include 'apache::params'

    File {
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_config_t',
        require => Package[$apache::params::packages],
        before  => Service[$apache::params::service_name],
        notify  => Service[$apache::params::service_name],
    }

    if $source != undef {
        file { "/etc/httpd/conf.d/${name}.conf":
            source  => "${source}",
        }
    } elsif $content != undef {
        file { "/etc/httpd/conf.d/${name}.conf":
            content => "${content}",
        }
    } else {
        fail ('One of $source or $content is required.')
    }

}
