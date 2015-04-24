# modules/dart/manifests/mdct_dev12/packaging.pp
#
# == Class: dart::mdct_dev12::packaging
#
# Manages software packaging features on John Florian's workstation.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_dev12::packaging {

    class { '::koji::cli':
        hub       => 'http://mdct-koji.dartcontainer.com/kojihub',
        web       => 'http://mdct-koji.dartcontainer.com/koji',
        downloads => 'http://mdct-koji.dartcontainer.com/kojifiles',
        top_dir   => '/srv/koji',     # TODO: share via NFS?
    }

    include '::dart::subsys::sigul::params'

    class { '::sigul::client':
        bridge_hostname => $::dart::subsys::sigul::params::bridge_hostname,
        server_hostname => $::dart::subsys::sigul::params::server_hostname,
    }

}
