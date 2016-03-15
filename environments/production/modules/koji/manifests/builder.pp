# modules/koji/manifests/builder.pp
#
# == Class: koji::builder
#
# Manages a host as a Koji Builder.
#
# === Parameters
#
# ==== Required
#
# [*client_cert*]
#   Puppet source URI providing the builder's identity certificate which must
#   be in PEM format.
#
# [*ca_cert*]
#   Puppet source URI providing the CA certificate that signed "client_cert".
#
# [*web_ca_cert*]
#   Puppet source URI providing the CA certificate that signed the Koji-Web
#   certificate.
#
# [*hub*]
#   URL of your Koji-Hub service.
#
# [*downloads*]
#   URL of your package download site.
#
# [*top_dir*]
#   Name of the directory containing the "repos/" directory.
#
# ==== Optional
#
# [*allowed_scms*]
#   A space-separated list of tuples from which kojid is allowed to checkout.
#   The format of those tuples is:
#
#       host:repository[:use_common[:source_cmd]]
#
#   Incorrectly-formatted tuples will be ignored.
#
#   If use_common is not present, kojid will attempt to checkout a common/
#   directory from the repository.  If use_common is set to no, off, false, or
#   0, it will not attempt to checkout a common/ directory.
#
#   source_cmd is a shell command (args separated with commas instead of
#   spaces) to run before building the srpm.  It is generally used to retrieve
#   source files from a remote location.  If no source_cmd is specified, "make
#   sources" is run by default.
#
# [*debug*]
#   Enable verbose debugging for the Koji Builder.
#   One of: true or false (default).
#
# [*enable*]
#   Instance is to be started at boot.  Either true (default) or false.
#
# [*ensure*]
#   Instance is to be 'running' (default) or 'stopped'.
#
# [*failed_buildroot_lifetime*]
#   The number of seconds a buildroot should be retained by kojid after
#   a build failure occurs.  It is sometimes necessary to manually chroot into
#   the buildroot to determine exactly why a build failed and what might done
#   to resolve the issue.  The default is 4 hours (or 14,400 seconds).
#
#   It must be noted here that this feature is somewhat flakey because Koji
#   seems to set the expiration time based not on when the build started but
#   on some other event, likely when the buildroot was created.  This might
#   not sound all that different but bear in mind that kojid doesn't fully
#   destroy the build roots; it merely empties them.  So in effect, kojid can
#   reuse a buildroot -- one which may already be hours towards its
#   expiration.  If you wish to use this feature, you may want to use a value
#   of a day or more, but keep in mind you might then exhaust the storage
#   capacity of the "mock_dir".
#
# [*mock_dir*]
#   The directory under which mock will do its work and create buildroots.
#   The default is '/var/lib/mock'.
#
# [*smtp_host*]
#   The mail host to use for sending email notifications.  The Koji Builder
#   must be able to connect to this host via TCP on port 25.  The default is
#   'localhost'.
#
# [*work_dir*]
#   Name of the directory where temporary work will be performed.  The default
#   is '/tmp/koji'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class koji::builder (
        $client_cert,
        $ca_cert,
        $web_ca_cert,
        $hub,
        $downloads,
        $top_dir,
        $allowed_scms=undef,
        $debug=false,
        $enable=true,
        $ensure='running',
        $failed_buildroot_lifetime=60 * 60 * 4,
        $mock_dir='/var/lib/mock',
        $smtp_host='localhost',
        $work_dir='/tmp/koji',
    ) inherits ::koji::params {

    validate_bool($debug)

    package { $::koji::params::builder_packages:
        ensure => installed,
        notify => Service[$::koji::params::builder_services],
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        before    => Service[$::koji::params::builder_services],
        notify    => Service[$::koji::params::builder_services],
        subscribe => Package[$::koji::params::builder_packages],
    }

    file {
        '/etc/kojid/kojid.conf':
            content => template('koji/builder/kojid.conf');

        '/etc/sysconfig/kojid':
            content => template('koji/builder/kojid');

        '/etc/kojid/client.pem':
            source  => $client_cert;

        '/etc/kojid/clientca.crt':
            source  => $ca_cert;

        '/etc/kojid/serverca.crt':
            source  => $web_ca_cert;
    }

    service { $::koji::params::builder_services:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}