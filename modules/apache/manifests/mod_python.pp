# modules/apache/manifests/mod_python.pp
#
# Synopsis:
#       Configures a host as an Apache HTTP server providing mod_python.


class apache::mod_python {

    package { 'mod_python':
        ensure  => installed,
    }

}
