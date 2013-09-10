# modules/jetbrains/manifests/params.pp
#
# Synopsis:
#       Parameters for the jetbrains module.


class jetbrains::params {

    $root = '/opt/jetbrains'

    $idea_root = "${root}/idea"
    $pycharm_root = "${root}/pycharm"
    $teamcity_root = "${root}/teamcity"

    $teamcity_buildserver_root = "${teamcity_root}/.BuildServer"
    $teamcity_etc_root = "${teamcity_root}/etc"

    $teamcity_rc = "${teamcity_etc_root}/rc"

}
