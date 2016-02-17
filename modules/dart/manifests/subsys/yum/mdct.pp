# modules/dart/manifests/subsys/yum/mdct.pp
#
# == Class: dart::subsys::yum::mdct
#
# Manages the Yum repository for MDCT software on a Dart host.
#
# This repository has been obsoleted by the Dart repository.  All hosts
# running Fedora 20 and newer should now use that instead.  The MDCT
# repository remains static "as is" for legacy systems running Fedora 19 or
# older.
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


class dart::subsys::yum::mdct {

    include '::dart::subsys::yum::params'

    # Rawhide systems begin life as the latest stable release and should be
    # fully puppetized prior to upgrading to rawhide.  Once there, they have
    # no need for this section, which would only throw errors anyway.
    if $::operatingsystemrelease != 'Rawhide' and $::operatingsystemrelease <= '19' {

        $pkg_release = $::operatingsystemrelease ? {
            '13'    => '13-1.dcc.noarch',
            '14'    => '14-1.dcc.noarch',
            '15'    => '15-1.dcc.noarch',
            '16'    => '16-1.dcc.noarch',
            '17'    => '17-1.dcc.noarch',
            '18'    => '18-2.fc18.noarch',
            '19'    => '19-2.fc19.noarch',
        }

        ::yum::repo { 'mdct':
            server_uri  => "${::dart::subsys::yum::params::fedora_repo_uri}/mdct/${::operatingsystemrelease}/${::architecture}",
            pkg_name    => 'fedora-mdct-release',
            pkg_release => $pkg_release,
        }

    }

}
