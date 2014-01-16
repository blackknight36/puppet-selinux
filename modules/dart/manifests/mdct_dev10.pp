# modules/dart/manifests/mdct-dev10.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Levi Harper

class dart::mdct_dev10 inherits dart::abstract::workstation_node {

    include 'jetbrains::idea'
    include 'dart::subsys::yum_cron'

}
