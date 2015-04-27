# modules/dart/manifests/subsys/koji/kojira.pp
#
# == Class: dart::subsys::koji::kojira
#
# Manages the Koji Kojira component.
#
# Prior to starting kojira (for Yum repository creation and maintenance),
# you will manually need to:
#
#       ssh koji
#       sudo -iu kojiadmin koji add-user kojira
#       sudo -iu kojiadmin koji grant-permission repo kojira
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::koji::kojira inherits ::dart::subsys::koji::params {

    class { '::koji::kojira':
        client_cert => "puppet:///modules/dart/koji/kojira-on-${::dart::subsys::koji::params::kojira_host}.pem",
        ca_cert     => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        web_ca_cert => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        hub         => $::dart::subsys::koji::params::hub,
        top_dir     => $::dart::subsys::koji::params::topdir,
        require     => Class['::dart::subsys::koji::autofs'],
    }

}
