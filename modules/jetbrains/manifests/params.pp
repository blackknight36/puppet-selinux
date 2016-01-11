# modules/jetbrains/manifests/params.pp
#
# == Class: jetbrains::params
#
# Parameters for the jetbrains puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class jetbrains::params {

    $root = '/opt/jetbrains'

    $idea_root = "${root}/idea"
    $pycharm_root = "${root}/pycharm"
    $rubymine_root = "${root}/rubymine"
    $teamcity_root = "${root}/teamcity"

    $teamcity_buildserver_root = "${teamcity_root}/.BuildServer"
    $teamcity_etc_root = "${teamcity_root}/etc"

    $teamcity_rc = "${teamcity_etc_root}/rc"

}
