# modules/koji/manifests/web.pp
#
# Synopsis:
#       Configures a host to provide the Koji-Web.
#
# Parameters:
#       Name__________  Notes_  Description___________________________________
#
#       secret                  undocumented in the Koji project
#
# Assumptions:
#       This class presently assumes that the Koji-Web component is deployed
#       on the same host as the Koji-Hub component.  Additional work in the
#       puppet resources would be required to allow these to be split apart
#       since both components require apache httpd and mod_ssl support.


class koji::web ( $secret ) {

    include 'koji::params'

    package { $koji::params::web_packages:
        ensure  => installed,
    }

    # Duplicates that in koji::hub.  See assumptions note above.
    #   class { 'apache':
    #       network_connect_db  => 'on',
    #       anon_write          => 'on',
    #   }

    include 'apache::mod_ssl'

    apache::site_config {
        # Duplicates that in koji::hub.  See assumptions note above.
        #   'ssl':
        #       source      => 'puppet:///modules/koji/httpd/ssl.conf',
        #       subscribe   => Class['apache::mod_ssl'];
        'kojiweb':
            source      => 'puppet:///modules/koji/web/kojiweb.conf',
            subscribe   => Package[$koji::params::web_packages];
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Class['apache'],
        notify      => Class['apache'],
        subscribe   => Package[$koji::params::web_packages],
    }

    file { '/etc/kojiweb/web.conf':
        content => template('koji/web/web.conf'),
    }

}
