# modules/jetbrains/manifests/params.pp
#
# Synopsis:
#       Parameters for the jetbrains module.


class jetbrains::params {

    $root = '/opt/jetbrains'

    $idea_root = "$root/idea"
    $pycharm_root = "$root/pycharm"
    $teamcity_root = "$root/teamcity"

}
