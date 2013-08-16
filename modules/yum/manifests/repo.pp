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
#       use_tsocks      1       Set to true if it's necessary to use a SOCKS
#                               proxy to reach $server_uri.
#
# Notes:
#
#       1. Default is false.


define yum::repo($server_uri, $pkg_name, $pkg_release, $use_tsocks=false) {

    $tsocks = $use_tsocks ? {
        true    => 'tsocks',
        default => '',
    }

    exec { "install-yum-repo-${name}":
        command => "$tsocks yum -y install ${server_uri}/${pkg_name}-${pkg_release}.rpm",
        unless  => "rpm -q ${pkg_name}",
    }

}
