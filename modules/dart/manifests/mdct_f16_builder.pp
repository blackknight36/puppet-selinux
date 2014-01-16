# modules/dart/manifests/mdct_f16_builder.pp
#
# Synopsis:
#       Package Builder for Fedora 16 Release
#
# Contact:
#       John Florian

class dart::mdct_f16_builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}
