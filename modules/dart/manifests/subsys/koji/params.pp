# modules/dart/manifests/subsys/koji/params.pp
#
# == Class: dart::subsys::koji::params
#
# Parameters for a Dart host as a Koji RPM package builder.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::koji::params {

    # An alternate home directory for local users so as to not clash with
    # autofs which dominates /home.
    $local_homes = '/var/local/home'

    $hub_host   = 'mdct-koji-f21.dartcontainer.com'

    $db_passwd  = 'mdct.koji'
    $db_user    = 'koji'
    $downloads  = "http://${hub_host}/kojifiles"
    $hub        = "http://${hub_host}/kojihub"
    $repodir    = '/mnt/mdct-new-repo'
    $topdir     = '/mnt/koji'
    $workdir    = '/var/tmp/koji'
    $web_passwd = 'D0gG0n31t'

}
