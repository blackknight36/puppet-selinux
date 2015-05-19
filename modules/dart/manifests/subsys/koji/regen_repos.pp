# modules/dart/manifests/subsys/koji/regen_repos.pp
#
# == Class: dart::subsys::koji::regen_repos
#
# Manages our buildroots' dependencies on external package repositories.
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


class dart::subsys::koji::regen_repos inherits ::dart::subsys::koji::params {

    include '::koji::helpers'

    class { '::koji::regen_repos':
        ext_repo_root => $::dart::subsys::koji::params::ext_repo_dir,
        owner         => 'repomgr',
        group         => 'repomgr',
        require       => [
            Class['::dart::subsys::koji::autofs'],
            Class['::dart::subsys::koji::hub'],
        ],
    }

    ::koji::buildroot_dependency {
        'f20-build':
            ext_repo_dirs => ['20/Everything', 'updates/20'],
            ;

        'f21-build':
            ext_repo_dirs => ['21/Everything', 'updates/21'],
            ;
    }

    include '::cron::daemon'

    ::cron::job { 'regen-repos':
        command => "systemd-cat ${::koji::params::regen_repos_bin}",
        minute  => '*/10',
        mailto  => $::dart::subsys::koji::params::admin_email,
        user    => 'repomgr',
    }

}
