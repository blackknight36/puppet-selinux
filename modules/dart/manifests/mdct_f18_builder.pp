# modules/dart/manifests/mdct_f18_builder.pp
#
# Synopsis:
#       Package Builder for Fedora 18 Release
#
# Contact:
#       John Florian

class dart::mdct_f18_builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}
