# modules/dart/manifests/mdct_f20_builder.pp
#
# Synopsis:
#       Package Builder for Fedora 20 Release
#
# Contact:
#       John Florian

class dart::mdct_f20_builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}
