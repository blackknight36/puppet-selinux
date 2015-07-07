# modules/dart/manifests/mdct_dev24.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Daniel Brown


class dart::mdct_dev24 inherits dart::abstract::workstation_node {

    include '::dart::abstract::idea'
    include '::dart::abstract::pycharm::community'
    include '::dart::subsys::koji::autofs'
    include '::dart::subsys::koji::cli'
    include '::dart::subsys::yum_cron'

}
