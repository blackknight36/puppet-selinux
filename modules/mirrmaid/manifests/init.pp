# modules/mirrmaid/manifests/init.pp
#
# Synopsis:
#       Configures a host for mirrmaid service.
#
# Note:
#       You will need to configure mirrmaid with one or more configuration
#       files via mirrmaid::config.


class mirrmaid {

    package { 'mirrmaid':
        ensure  => latest,
    }

}
