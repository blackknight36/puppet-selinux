# modules/jetbrains/manifests/pycharm.pp
#
# == Class: jetbrains::pycharm
#
# Configures a host to run JetBrains PyCharm.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class jetbrains::pycharm {

    include 'jetbrains'
    include 'jetbrains::params'

    File {
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
    }

    file { "${jetbrains::params::pycharm_root}":
        ensure  => directory,
        mode    => '0755',
        require => File['/opt/jetbrains'],
    }

    $launchers_path = "${jetbrains::params::pycharm_root}/launchers"
    file { "${jetbrains::pycharm::launchers_path}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::params::pycharm_root}"],
    }

    $pycharm_config = "${jetbrains::params::pycharm_root}/etc"
    file { "${pycharm_config}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::params::pycharm_root}"],
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

    #
    # Stable Releases
    #
    # Present policy plan is to enforce absence of old stable releases
    # to ensure that no more than two stable releases are installed at any
    # given time.

    jetbrains::pycharm_release { 'pycharm-3.0.2':
        build   => '3.0.2',
        edition => 'professional',
    }

    jetbrains::pycharm_release { 'pycharm-3.0.1':
        build   => '3.0.1',
        edition => 'professional',
        ensure  => 'absent',
    }

    #
    # EAP Releases
    #

    jetbrains::pycharm_release { 'pycharm-133.701':
        build   => '133.701',
        edition => 'professional',
    }

    jetbrains::pycharm_release { 'pycharm-133.551':
        build   => '133.551',
        edition => 'professional',
        ensure  => 'absent',
    }

}
