# /etc/puppet/modules/MODULE_NAME/manifests/definitions/DEFINE_NAME.pp
#
# Synopsis:
#       Installs a web-site configuration file for the Apache web server.
#
# Parameters:
#       name:           The name of the web site.
#       source:         The puppet URI for obtaining the web site's configuration file.
#
# Requires:
#       Class["MODULE_NAME"]
#
# Example usage:
#
#       include MODULE_NAME
#
#       MODULE_NAME::DEFINE_NAME { "acme":
#           notify  => Service["SERVICE_NAME"],
#           source  => "puppet:///private-host/acme.conf",
#       }


define MODULE_NAME::DEFINE_NAME ($ensure="present", $source) {

    file { "/CONFIG_PATH/conf.d/${name}.conf":
        ensure  => $ensure,
        owner   => "root",
        group   => "root",
        mode    => "0640",
        seluser => "system_u",
        selrole => "object_r",
        seltype => "httpd_config_t",
        require => Package["PACKAGE_NAME"],
        source  => "${source}",
    }

}
