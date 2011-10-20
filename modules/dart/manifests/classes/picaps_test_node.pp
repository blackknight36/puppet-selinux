# modules/dart/manifests/classes/picaps_test_node.pp
#
# Synopsis:
#       This class is used primarily for servers that are used for testing
#       PICAPS through various stages of deployment at a plant.

class dart::picaps_test_node inherits dart::server_node {

    # AOS devices pull media-playback content using rsync.
    include rsync-server

    # That same media-playback content is pushed in via Windows systems.
    include samba

}
