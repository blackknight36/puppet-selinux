# modules/dart/manifests/mdct_dev10.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Levi Harper

class dart::mdct_dev10 inherits dart::abstract::workstation_node {

    include 'dart::abstract::pycharm::community'
    include 'dart::subsys::yum_cron'
    include 'jetbrains::idea'

}
