# modules/dart/manifests/mdct_f15_builder.pp
#
# Synopsis:
#       Package Builder for Fedora 15 Release
#
# Contact:
#       John Florian

class dart::mdct_f15_builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}
