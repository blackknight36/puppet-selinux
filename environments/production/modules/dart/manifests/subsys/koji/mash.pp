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
        keys          => $::dart::subsys::koji::params::rpm_signing_keys,
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

        'f21-candidates':
            comp_dir     => 'candidates/21',
            dist_tag     => 'f21-candidates',
            repoview_url => sprintf($repoview_url_fmt, 'candidates', 21),
            ;

        'f21-testing':
            comp_dir     => 'testing/21',
            dist_tag     => 'f21-testing',
            repoview_url => sprintf($repoview_url_fmt, 'testing', 21),
            ;

        'f21-released':
            comp_dir     => 'released/21',
            dist_tag     => 'f21-released',
            repoview_url => sprintf($repoview_url_fmt, 'released', 21),
            ;

        'f22-candidates':
            comp_dir     => 'candidates/22',
            dist_tag     => 'f22-candidates',
            repoview_url => sprintf($repoview_url_fmt, 'candidates', 22),
            ;

        'f22-testing':
            comp_dir     => 'testing/22',
            dist_tag     => 'f22-testing',
            repoview_url => sprintf($repoview_url_fmt, 'testing', 22),
            ;

        'f22-released':
            comp_dir     => 'released/22',
            dist_tag     => 'f22-released',
            repoview_url => sprintf($repoview_url_fmt, 'released', 22),
            ;

        'f23-candidates':
            comp_dir     => 'candidates/23',
            dist_tag     => 'f23-candidates',
            repoview_url => sprintf($repoview_url_fmt, 'candidates', 23),
            ;

        'f23-testing':
            comp_dir     => 'testing/23',
            dist_tag     => 'f23-testing',
            repoview_url => sprintf($repoview_url_fmt, 'testing', 23),
            ;

        'f23-released':
            comp_dir     => 'released/23',
            dist_tag     => 'f23-released',
            repoview_url => sprintf($repoview_url_fmt, 'released', 23),
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
