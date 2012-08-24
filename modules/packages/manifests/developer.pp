# modules/packages/manifests/developer.pp

class packages::developer {

    include rpm-build-tools

    ### Universal Package Inclusion ###

    package { [

        'cmake',
        'cvs',
        'gcc',
        'gcc-c++',
        'git',
        'gitk',
        'gnupg',                # required for rpmbuild --sign
        'gnupg2',               # required for rpmbuild --sign
        'ipython',
        'kodos',
        'meld',
        'nasm',
        'python-devel',
        'python-tools',
        'python3-devel',
        'python3-tools',
        'redhat-rpm-config',
        'rpmdevtools',
        'ruby-devel',
        'subversion',
        'unzip',                # needed to repack jars when building rpms
        'zip',                  # needed to repack jars when building rpms

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $operatingsystem == 'Fedora' {

        if  $operatingsystemrelease == 'Rawhide' or
            $operatingsystemrelease >= 12
        {
            package { [
                'python-ipaddr',
                ]:
                ensure  => installed,
            }
        }

    }

    ### Universal Package Exclusion ###

    package { [

        ]:
        ensure => absent,
    }

    ### Select Package Exclusion ###

    # none

}
