# modules/dart/manifests/mdct_sigul_bridge_f21.pp
#
# == Class: dart::mdct_sigul_bridge_f21
#
# Manages a Dart host as a bridge to our Sigul server.
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


class dart::mdct_sigul_bridge_f21 inherits ::dart::abstract::sigul_node {

    include '::dart::subsys::koji::autofs'
    include '::dart::subsys::koji::cli'
    include '::dart::subsys::koji::params'

    network::interface { 'eth0':
        template   => 'static',
        ip_address => '10.1.192.138',
        netmask    => '255.255.0.0',
        gateway    => '10.1.0.25',
        stp        => 'no',
    }

    # NB: sigul-0.100-4.fc21.noarch ships with SysV init scripts that behave
    # poorly in that Puppet can't seem to start them and if the Server is
    # started by hand, not all child processes will terminate together with
    # service shutdown.  Reported here:
    # https://bugzilla.redhat.com/show_bug.cgi?id=1217068
    #
    # I have created systemd unit files for the Sigul services that behave as
    # expected.  They're available with RHBZ#1217068, but are otherwise
    # unmanaged in the hopes that they'll be packaged in future versions.
    class { '::sigul::bridge':
        client_cert  => "puppet:///modules/dart/koji/kojiweb-on-${::dart::subsys::koji::params::web_host}.pem",
        ca_cert      => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        hub_ca_cert  => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        downloads    => $::dart::subsys::koji::params::downloads,
        hub          => $::dart::subsys::koji::params::hub,
        nss_password => $::dart::subsys::sigul::params::nss_password,
        top_dir      => $::dart::subsys::koji::params::topdir,
        web          => "http://${::fqdn}/koji",
    }

    class { '::sigul::auto_signer':
        hub_hostname    => $::dart::subsys::koji::params::hub_host,
        client_cert     => "puppet:///modules/dart/koji/ass-on-${::fqdn}.pem",
        ca_cert         => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        web_ca_cert     => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        bridge_hostname => $::dart::subsys::sigul::params::bridge_hostname,
        server_hostname => $::dart::subsys::sigul::params::server_hostname,
        nss_password    => 'Bung0',
        key_map         => {
            'mdct-legacy' => {
                'key_id' => '0F9F5D3B',
                'pass'   => 'mdct.gpg',
                'tag'    => 'f20-candidates',
                'v3'     => true,
            },
            'mdct-legacy' => {
                'key_id' => '0F9F5D3B',
                'pass'   => 'mdct.gpg',
                'tag'    => 'f21-candidates',
                'v3'     => true,
            },
        },
    }

}
