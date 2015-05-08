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
    $rpm_signing_keys = ['0F9F5D3B']
    $repoview_url_fmt = join(
            [ $repoview_server,
              '/pub/fedora/dart/%s/%d/%%(arch)s/',
              'repoview/index.html'
            ],
            '')

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

    ::koji::mash::repo {
        'f20-candidates':
            comp_dir     => 'candidates/20',
            dist_tag     => 'f20-candidates',
            repoview_url => sprintf($repoview_url_fmt, 'candidates', 20),
            ;

        'f20-testing':
            comp_dir     => 'testing/20',
            dist_tag     => 'f20-testing',
            repoview_url => sprintf($repoview_url_fmt, 'testing', 20),
            ;

        'f20-released':
            comp_dir     => 'released/20',
            dist_tag     => 'f20-released',
            repoview_url => sprintf($repoview_url_fmt, 'released', 20),
            ;
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
