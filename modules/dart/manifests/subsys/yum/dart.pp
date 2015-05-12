# modules/dart/manifests/subsys/yum/dart.pp
#
# == Class: dart::subsys::yum::dart
#
# Manages the Yum repository for Dart software on a Dart host.
#
# This repository obsoletes the legacy MDCT repository for hosts running
# Fedora 20 or newer.  Older legacy hosts must continue to use the legacy MDCT
# repository which is now static "as is".
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


class dart::subsys::yum::dart {

    include '::dart::subsys::yum::params'

    # Rawhide systems begin life as the latest stable release and should be
    # fully puppetized prior to upgrading to rawhide.  Once there, they have
    # no need for this section, which would only throw errors anyway.
    if $::operatingsystemrelease != 'Rawhide' and $::operatingsystemrelease >= 20 {

        $pkg_release = $::operatingsystemrelease ? {
            '20'    => '20-2.fc20.noarch',
            '21'    => '21-2.fc21.noarch',
        }

        ::yum::repo { 'dart':
            server_uri  => "${::dart::subsys::yum::params::fedora_repo_uri}/dart/released/${::operatingsystemrelease}/${::architecture}",
            pkg_name    => 'fedora-dart-release',
            pkg_release => $pkg_release,
        }

    }

}
