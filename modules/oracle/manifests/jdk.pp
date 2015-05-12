# modules/oracle/manifests/jdk.pp
#
# == Define: oracle::jdk
#
# Installs one of Oracle's JDKs.
#
# === Parameters
#
# [*namevar*]
#   An arbitrary identifier for the JDK instance.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*version*]
#   JDK version number (e.g., '7').  Required except when *ensure* is
#   'latest'.
#
# [*update*]
#   JDK version's update number (e.g., '25').  Required except when *ensure*
#   is 'latest'.  Use '' for the initial release of a new version where there
#   is no update number suffixed.
#
# [*arch*]
#   Oracle's packaging architecture (e.g., 'x64' for 64-bit Intel or 'i586'
#   for 32-bit Intel).
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define oracle::jdk (
        $ensure='present', $version=undef, $update=undef, $arch='x64',
) {

    validate_re($version, '^\d+$', '$version is invalid or not defined')
    validate_re($update, '^\d*$', '$update is invalid or not defined')

    # Oracle, like Sun before them, has horrible packaging practices where the
    # rpm file name only resembles the rpm's %Name field.

    if $update == '' {
        $update_tag1 = ''
        $update_tag2 = ''
    } else {
        $update_tag1 = "u$update"
        $update_tag2 = "_$update"
    }

    exec { "install oracle $name":
        command => "rpm -i --force http://mdct-00fs.dartcontainer.com/pub/oracle/jdk-${version}${update_tag1}-linux-${arch}.rpm",
        unless  => "rpm -q jdk-1.${version}.0${update_tag2}-fcs",
        # Allow extra time, especially for trans-WAN installations.
        timeout => 1200,
    }

}
