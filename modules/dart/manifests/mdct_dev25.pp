# modules/dart/manifests/mdct_dev25.pp
#
# Synopsis:
#       Technician Workstation
#
# Contact:
#       Gregory Matheny

class dart::mdct_dev25 inherits dart::abstract::workstation_node {
    include 'dart::subsys::yum_cron'
}
