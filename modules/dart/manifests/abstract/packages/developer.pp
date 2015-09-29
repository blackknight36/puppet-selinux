# modules/dart/manifests/abstract/packages/developer.pp

class dart::abstract::packages::developer {

    include 'rpm_build_tools'

    ### Universal Package Inclusion ###

    package { [

        'cmake',
        'cvs',
        'epydoc',
        'gcc',
        'gcc-c++',
        'git',
        'gitk',
        'gnupg',                # required for rpmbuild --sign
        'gnupg2',               # required for rpmbuild --sign
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
        'tito',
        'unzip',                # needed to repack jars when building rpms
        'zip',                  # needed to repack jars when building rpms

        ]:
        ensure => installed,
    }

    ### Select Package Inclusion ###

    if $::operatingsystem == 'Fedora' {

        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= 12
        {
            package { [
                'python-ipaddr',
                ]:
                ensure  => installed,
            }
        }

        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= 15
        {
            package { [
                'jtbox',
                ]:
                ensure  => installed,
            }
        }
        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= 18
        {
            package { [
                'python3-django',
                'python3-sphinx',
                'rubygem-puppet-lint',
                'rubygem-ronn',
                ]:
                ensure  => installed,
            }
        }
        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= 19
        {
            package { [
                'rubygem-git-up',
                ]:
                ensure  => installed,
            }
        }
        if  $::operatingsystemrelease == 'Rawhide' or
            $::operatingsystemrelease >= 20
        {
            package { [
                'python3-mdct-doc',
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
