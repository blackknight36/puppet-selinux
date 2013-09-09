# modules/oracle/manifests/jdk.pp
#
# Synopsis:
#       Installs JDK package(s) from Oracle.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       ensure          1       instance is to be present/absent/latest
#
#       version         2       JDK version number (e.g., '7')
#
#       update          2       JDK update number (e.g., '25')
#
#       arch                    platform architecure (i.e., 'x64' or 'i586')
#
# Notes:
#
#       1. Default is 'present'.  TODO: support 'absent'.
#
#       2. Default is undef, but must be specified unless $ensure is
#       'present'.


define oracle::jdk ($ensure='present', $version=undef, $update=undef, $arch='x64') {

    if $ensure == 'latest' {
        # Don't alter the latest values until you've ensured that both 32- and
        # 64-bit versions of the package are available in /pub/oracle!!!
        $rpm_version = '7'
        $rpm_update = '25'
    } else {
        if $version == undef or $update == undef {
            fail ('$version and $update must specified unless $ensure is set to "latest".')
        } else {
            $rpm_version = "$version"
            $rpm_update = "$update"
        }
    }

    exec { "install oracle $name":
        command => "rpm -i --force http://mdct-00fs.dartcontainer.com/ftp/pub/oracle/jdk-${rpm_version}u${rpm_update}-linux-${arch}.rpm",
        unless  => "rpm -q jdk-1.${rpm_version}.0_${rpm_update}-fcs",
    }

}
