# modules/dart/manifests/mdct-dev9.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Nathan Nephew

class dart::mdct-dev9 inherits dart::abstract::workstation_node {

    include 'jetbrains::idea'
    include 'dart::subsys::yum_cron'

}
