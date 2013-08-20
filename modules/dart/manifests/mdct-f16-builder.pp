# modules/dart/manifests/mdct-f16-builder.pp
#
# Synopsis:
#       Package Builder for Fedora 16 Release
#
# Contact:
#       John Florian

class dart::mdct-f16-builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}
