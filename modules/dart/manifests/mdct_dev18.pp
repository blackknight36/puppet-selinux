# modules/dart/manifests/mdct_dev18.pp
#
# Synopsis:
#       Technician Workstation
#
# Contact:
#       Kris Doyle

class dart::mdct_dev18 inherits dart::abstract::workstation_node {
    include 'dart::subsys::yum_cron'
}
