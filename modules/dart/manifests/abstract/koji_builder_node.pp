# modules/dart/manifests/abstract/koji_builder_node.pp
#
# == Class: dart::abstract::koji_builder_node
#
# Manages a host as a Koji RPM package builder.
#
# Be sure to do the following prior to starting kojid (the builder daemon):
#
#       ssh koji
#       sudo -iu kojiadmin koji add-host kojibuilder1.example.com i386 x86_64
#
# If you fail to do so you'll need to manually remove entries from the
# sessions and users table before the build daemon (kojid) can be run
# successfully.
#
# === Parameters
#
# ==== Required
# [*mock_disk_uuid*]
#   The UUID of the block-device to be mounted on /var/lib/mock, which
#   provides mock's primary work directory.  See also blkid(8).
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::abstract::koji_builder_node (
        $mock_disk_uuid,
    ) inherits ::dart::abstract::guarded_server_node {

    include '::dart::subsys::koji::autofs'
    include '::dart::subsys::koji::params'

    ::sendmail::alias { 'root':
        recipient   => 'john.florian@dart.biz',
    }

    class { '::mock::common':
    } ->

    mount { '/var/lib/mock':
        ensure  => 'mounted',
        atboot  => true,
        device  => "/dev/disk/by-uuid/${mock_disk_uuid}",
        fstype  => 'auto',
        options => 'defaults',
    } ->

    class { '::koji::builder':
        client_cert  => "puppet:///modules/dart/koji/kojid-on-${::fqdn}.pem",
        ca_cert      => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        web_ca_cert  => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        hub          => $::dart::subsys::koji::params::hub,
        downloads    => $::dart::subsys::koji::params::downloads,
        top_dir      => $::dart::subsys::koji::params::topdir,
        work_dir     => $::dart::subsys::koji::params::workdir,
        allowed_scms => 'mdct-00fs.dartcontainer.com:/home/git/*.git:no',
        debug        => $::dart::subsys::koji::params::debug,
        require      => Class['::dart::subsys::koji::autofs'],
    }

}
