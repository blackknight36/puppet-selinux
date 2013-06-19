# modules/jetbrains/manifests/pycharm.pp
#
# Synopsis:
#       Configures a host to run JetBrains PyCharm.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       NONE
#
# Requires:
#       NONE
#
# Example Usage:
#
#       include jetbrains::pycharm

class jetbrains::pycharm {

    include jetbrains

    File {
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
    }

    $root = '/opt/jetbrains/pycharm'
    file { "${jetbrains::pycharm::root}":
        ensure  => directory,
        mode    => '0755',
        require => File['/opt/jetbrains'],
    }

    $launchers_path = "${jetbrains::pycharm::root}/launchers"
    file { "${jetbrains::pycharm::launchers_path}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::pycharm::root}"],
    }

    $pycharm_config = "${jetbrains::pycharm::root}/etc"
    file { "${pycharm_config}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::pycharm::root}"],
    }

    $pycharm_vmoptions = "${pycharm_config}/vmoptions"
    file { "${pycharm_vmoptions}":
        source  => 'puppet:///modules/jetbrains/pycharm/vmoptions',
        require => File["${pycharm_config}"],
    }

    $pycharm_rc = "${pycharm_config}/rc"
    file { "${pycharm_rc}":
        content => template('jetbrains/pycharm/rc'),
        require => File["${pycharm_config}"],
    }

    # Stable releases are named with the release, but extract to the
    # build.
    #
    # Present policy plan is to enforce absence of old stable releases
    # to ensure that no more than two stable releases are installed at any
    # given time.

    jetbrains::pycharm-release { 'pycharm-2.7.3':
        build   => '2.7.3',
    }

    jetbrains::pycharm-release { 'pycharm-2.7.2':
        build   => '2.7.2',
        ensure  => 'absent',
    }

    # EAP releases are simpler as their name reflects the build.

    jetbrains::pycharm-release { 'pycharm-129.696':
        build   => '129.696',
    }

    jetbrains::pycharm-release { 'pycharm-129.258':
        build   => '129.258',
        ensure  => 'absent',
    }

}
