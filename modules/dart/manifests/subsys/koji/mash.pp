# modules/dart/manifests/subsys/koji/mash.pp
#
# == Class: dart::subsys::koji::mash
#
# Manages the Koji mash component.
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


class dart::subsys::koji::mash inherits ::dart::subsys::koji::params {

    $repoview_server = 'http://mdct-00fs.dartcontainer.com'
    $rpm_signing_keys = ['6004207A']

    class { '::koji::mash':
        hub      => $::dart::subsys::koji::params::hub,
        repo_dir => $::dart::subsys::koji::params::repodir,
        top_dir  => $::dart::subsys::koji::params::topdir,
        require  => [
            Class['::dart::subsys::koji::autofs'],
            Class['::dart::subsys::koji::hub'],
        ],
    }

    Koji::Mash::Repo {
        hash_packages => false,
        keys          => $rpm_signing_keys,
    }

    ::koji::mash::repo { 'f20-candidates':
        comp_dir     => 'candidates/20',
        dist_tag     => 'f20-candidates',
        repoview_url => "${repoview_server}/pub/fedora/dart/candidates/20/%(arch)s/repoview/index.html",
    }

    ::koji::mash::repo { 'f20-testing':
        comp_dir     => 'testing/20',
        dist_tag     => 'f20-testing',
        repoview_url => "${repoview_server}/pub/fedora/dart/testing/20/%(arch)s/repoview/index.html",
    }

    ::koji::mash::repo { 'f20-released':
        comp_dir     => 'released/20',
        dist_tag     => 'f20-released',
        repoview_url => "${repoview_server}/pub/fedora/dart/released/20/%(arch)s/repoview/index.html",
    }

    # TODO: Replace this cron job with an event driven model, perhaps using
    # the incron package.
    include '::cron::daemon'

    ::cron::job { 'mash-everything':
        command => "systemd-cat ${::koji::params::mash_everything_bin}",
        minute  => '*/5',
        mailto  => $::dart::subsys::koji::params::admin_email,
        user    => 'repomgr',
    }

}
