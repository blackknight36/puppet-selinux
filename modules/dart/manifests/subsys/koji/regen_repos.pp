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

    # buildroot_dependency maintenance policy:
    #   1. Add a new buildroot_dependency to begin supporting a new Fedora
    #   release.
    #
    #   2. Delete an old buildroot_dependency when the Fedora release reaches
    #   EoL but only after our mirror has quiesced.
    ::koji::buildroot_dependency {
        'f21-build':
            ext_repo_dirs => ['21/Everything', 'updates/21'],
            ;

        'f22-build':
            ext_repo_dirs => ['22/Everything', 'updates/22'],
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
