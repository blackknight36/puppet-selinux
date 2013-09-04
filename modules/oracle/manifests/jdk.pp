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
#       ensure          1       instance is to be present/absent
#
#       version                 JDK version number (e.g., '7')
#
#       update                  JDK update number (e.g., '25')
#
#       arch                    platform architecure (i.e., 'x64' or 'i586')
#
# Notes:
#
#       1. Default is 'present'.


define oracle::jdk ($ensure='present', $version, $update, $arch='x64') {

    exec { "install oracle $name":
        command => "rpm -i --force http://mdct-00fs.dartcontainer.com/ftp/pub/oracle/jdk-${version}u${update}-linux-${arch}.rpm",
        unless  => "rpm -q jdk-1.${version}.0_${update}-fcs",
    }

}
