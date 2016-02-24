# modules/dart/manifests/subsys/koji/params.pp
#
# == Class: dart::subsys::koji::params
#
# Parameters for a Dart's Koji infrastructure.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::koji::params inherits ::koji::params {

    # Who should get any administrative type email?
    $admin_email    = 'john.florian@dart.biz'

    # a central toggle for debugging Koji's various components
    $debug          = false

    # host providing the Koji Hub, an XML-RPC server that coordinates all
    # resources and tasks
    $hub_host       = 'mdct-koji-f21.dartcontainer.com'

    # host providing the Koji garbage collector service
    $koji_gc_host   = $hub_host

    # host providing the Kojira component for repository maintenance.
    $kojira_host    = $hub_host

    # host providing the Koji Web portal for users.
    $web_host       = $hub_host

    # well known URLs on the Koji Hub
    $downloads      = "http://${hub_host}/kojifiles"
    $hub            = "http://${hub_host}/kojihub"

    # an alternate home directory for local users so as to not clash with
    # autofs which dominates /home
    $local_homes    = '/var/local/home'

    # details of the Koji database
    $db_passwd      = 'mdct.koji'
    $db_user        = 'koji'

    # various directory locations used by one or more Koji services
    $ext_repo_dir   = '/pub/fedora'
    $repodir        = '/mnt/dart-repo'
    $topdir         = '/mnt/koji'
    $workdir        = '/var/tmp/koji'

    # details of the Koji Web service
    $web_passwd     = 'D0gG0n31t'

    # a map of all extant signing keys
    $rpm_signing_keys = {
        'mdct-legacy' => '0F9F5D3B',
    }
}
