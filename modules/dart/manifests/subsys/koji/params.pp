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

    # host providing the Koji Hub, an XML-RPC server that coordinates all
    # resources and tasks
    $hub_host   = 'mdct-koji-f21.dartcontainer.com'

    # well known URLs on the Koji Hub
    $downloads  = "http://${hub_host}/kojifiles"
    $hub        = "http://${hub_host}/kojihub"

    # an alternate home directory for local users so as to not clash with
    # autofs which dominates /home
    $local_homes = '/var/local/home'

    # details regarding the Koji database
    $db_passwd  = 'mdct.koji'
    $db_user    = 'koji'

    # various directory locations used by one or more Koji services
    $repodir    = '/mnt/mdct-new-repo'
    $topdir     = '/mnt/koji'
    $workdir    = '/var/tmp/koji'

    # details regard the Koji Web service
    $web_passwd = 'D0gG0n31t'

}
