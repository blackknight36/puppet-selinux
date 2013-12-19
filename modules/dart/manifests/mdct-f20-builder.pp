# modules/dart/manifests/mdct-f20-builder.pp
#
# Synopsis:
#       Package Builder for Fedora 20 Release
#
# Contact:
#       John Florian

class dart::mdct-f20-builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}
