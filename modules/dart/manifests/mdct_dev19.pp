# modules/dart/manifests/mdct-dev19.pp
#
# Synopsis:
#       Technician Workstation
#
# Contact:
#       Elizabeth Scott

class dart::mdct_dev19 inherits dart::abstract::workstation_node {
    include 'dart::subsys::yum_cron'
}
