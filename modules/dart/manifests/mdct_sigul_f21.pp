# modules/dart/manifests/mdct_sigul_f21.pp
#
# == Class: dart::mdct_sigul_f21
#
# Manages a Dart host as a Sigul server.
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


class dart::mdct_sigul_f21 inherits ::dart::abstract::sigul_node {

    network::interface { 'eth0':
        template   => 'static',
        ip_address => '10.1.192.139',
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
    class { '::sigul::server':
        bridge_hostname => $::dart::subsys::sigul::params::bridge_hostname,
        nss_password    => $::dart::subsys::sigul::params::nss_password,
    }

    # Strangely rpm-sign is not pulled as a dependency by the sigul package,
    # though it absolutely is a requirement for sigul_server.  Reported here:
    # https://bugzilla.redhat.com/show_bug.cgi?id=1215678
    #
    # TODO: According to CLOSE of rhbz#1215678, this can be removed as of F23.
    package { 'rpm-sign':
        ensure => installed,
    }

}
