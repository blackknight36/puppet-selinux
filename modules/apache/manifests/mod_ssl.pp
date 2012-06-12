# modules/apache/manifests/mod_ssl.pp
#
# Synopsis:
#       Configures a host as an Apache HTTP server providing mod_ssl.
#
# Example:
#       include 'apache::mod_ssl'

class apache::mod_ssl {

    include 'apache'
    include 'lokkit'

    package { 'mod_ssl':
        ensure  => installed,
    }

    lokkit::tcp_port { 'https':
        port    => '443',
    }

}
