# modules/sigul/manifests/auto_signer.pp
#
# == Class: sigul::auto_signer
#
# Manages a local user account, script, cron job and other related resources
# so as to auto-sign Koji builds with Sigul.
#
# === Requirements
#
# This class expects that the Koji CLI is configured.  Typically this would be
# accomplished with Class[koji::cli].
#
# === Parameters
#
# ==== Required
#
# [*bridge_hostname*]
#   FQDN of the Sigul Bridge.
#
# [*client_cert*]
#   Puppet source URI providing the signer's identity certificate for client
#   authentication to the Koji-Web service.  The certificate must be in PEM
#   format.
#
# [*ca_cert*]
#   Puppet source URI providing the CA certificate that signed "client_cert".
#
# [*web_ca_cert*]
#   Puppet source URI providing the CA certificate that signed the Koji-Web
#   certificate.
#
# [*hub_hostname*]
#   FQDN of the Koji Hub.
#
# [*key_map*]
#   A Ruby hash expressing each of the Sigul key names and the Koji/GPG key ID
#   to which they are associated along with a boolean value indicating whether
#   Sigul is to sign using a PGP version 3 format signature.  For example:
#       key_map => {
#           'mdct-legacy' => {
#               'key_id'    => '0F9F5D3B',
#               'pass'      => 'mdct.gpg',
#               'tag'       => 'f20-candidates',
#               'v3'        => true,
#           },
#       }
#
# [*nss_password*]
#   Password that secures the NSS certificate database belonging to "user".
#
# [*server_hostname*]
#   FQDN of the Sigul Server.
#
# ==== Optional
#
# [*debug*]
#   If true, debug-level messages will be enabled.  These messages will be
#   emailed to "root" on the local host.  The default is false.
#
# [*user*]
#   The user name to perform the automatic signing.  Defaults to "ass" (the
#   Automated Sigul Signer).
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class sigul::auto_signer (
        $hub_hostname,
        $client_cert,
        $ca_cert,
        $web_ca_cert,
        $bridge_hostname,
        $server_hostname,
        $nss_password,
        $key_map,
        $debug=false,
        $user='ass',
    ) inherits ::sigul::params {

    include '::sigul'

    $ass_home = '/var/lib/auto_sigul_signer'
    $koji_dir = "${ass_home}/.koji"
    $sigul_dir = "${ass_home}/.sigul"
    $script = '/usr/local/libexec/sigulsign_unsigned.py'

    user { $user:
        comment => 'Automated Sigul Signer',
        home    => $ass_home,
        shell   => '/bin/false',
        system  => true,
    }

    File {
        owner   => $user,
        group   => $user,
        mode    => '0640',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'var_lib_t',
        require => User[$user],
    }

    file {
        $ass_home:
            ensure => directory,
            ;
        $koji_dir:
            ensure => directory,
            ;
        "${koji_dir}/client.crt":
            source => $client_cert,
            ;
        "${koji_dir}/clientca.crt":
            source => $ca_cert,
            ;
        "${koji_dir}/serverca.crt":
            source => $web_ca_cert,
            ;
        $script:
            content => template('sigul/sigulsign_unsigned.py'),
            mode    => '0754',
            ;
    } ->

    ::sigul::client_config { "${sigul_dir}/client.conf":
        bridge_hostname => $bridge_hostname,
        server_hostname => $server_hostname,
        nss_password    => $nss_password,
    } ->

    ::cron::jobfile { 'sigulsign_unsigned':
        content => template('sigul/sigulsign_unsigned.cron'),
        mode    => '0640',
    }

}
