# modules/dart/manifests/mdct-dev11.pp
#
# Synopsis:
#       Technician Workstation
#
# Contact:
#       Chris Pugh

class dart::mdct_dev11 inherits dart::abstract::workstation_node {
    include 'dart::subsys::yum_cron'
}
