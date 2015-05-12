# modules/dart/manifests/subsys/yum/params.pp
#
# Synopsis:
#       Parameters for the Dart's yum setups.


class dart::subsys::yum::params {

    case $::operatingsystem {
        Fedora: {
            $fedora_repo_uri = 'http://mdct-00fs.dartcontainer.com/pub/fedora'
        }

        default: {
            fail ("The yum module is not yet supported on ${::operatingsystem}.")
        }

    }

}
