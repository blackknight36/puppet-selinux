# modules/dart/manifests/mdct-dev18.pp
#
# Synopsis:
#       Technician Workstation
#
# Contact:
#       Kris Doyle

class dart::mdct-dev18 inherits dart::abstract::workstation_node {
    include 'dart::subsys::yum_cron'
}
