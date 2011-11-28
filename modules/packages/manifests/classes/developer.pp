# modules/packages/manifests/classes/developer.pp

class packages::developer {

    include rpm-build-tools

    ### Universal Package Inclusion ###

    package { [

        'cvs',
        'gcc',
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
        'rpmdevtools',
        'subversion',

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $operatingsystem == 'Fedora' {

        if $operatingsystemrelease >= 12 {
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
