# modules/dart/manifests/subsys/sigul/params.pp
#
# == Class: dart::subsys::sigul::params
#
# Parameters for a Dart's Sigul infrastructure.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::sigul::params {

    # The hostname acting as the Sigul Bridge.
    $bridge_hostname = 'mdct-sigul-bridge-f21.dartcontainer.com'

    # The hostname acting as the Sigul Server.
    $server_hostname = 'mdct-sigul-f21.dartcontainer.com'

    # The Client, Hub and Server can all have distinct passwords for their
    # private NSS certificate database, but to keep things simple here they
    # all share the same one.
    $nss_password = 'Signing@Dart'

    # The email address that is to receive root's email for hosts within the
    # Sigul infrastructure.
    $root_email_recipient = 'john.florian@dart.biz'

}
