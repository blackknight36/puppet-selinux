# modules/yum/manifests/repo.pp
#
# Synopsis:
#       Installs a repository configuration for yum.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       server_uri              URI referencing the directory containing
#                               $pkg_name.
#
#       pkg_name                Name of the RPM file in $server_uri that, if
#                               installed, would configure the repository.
#                               This should only contain the N portion of
#                               NEVR.
#
#       pkg_release             The remainder of $pkg_name, sans the '.rpm'
#                               suffix, i.e., the EVR portion of NEVR.
#
# Notes:
#
#       NONE


define yum::repo($server_uri, $pkg_name, $pkg_release) {

    exec { "install-yum-repo-${name}":
        command => "yum -y install ${server_uri}/${pkg_name}-${pkg_release}.rpm",
        unless  => "rpm -q ${pkg_name}",
    }

}
