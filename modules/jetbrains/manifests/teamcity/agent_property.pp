# modules/jetbrains/manifests/teamcity/agent_property.pp
#
# == Define: jetbrains::teamcity::agent_property
#
# Configures a single, specific JetBrains TeamCity Build Agent property.
#
# === Parameters
#
# [*namevar*]
#   The property name.
#
# [*value*]
#   Value that property is to take.
#
# [*props_file*]
#   Path to Build Agent's configuration properties file.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define jetbrains::teamcity::agent_property ($props_file, $value) {

    include 'jetbrains::teamcity::agent'

    exec { "configure-${name}":
        command => "sed -ri 's|^(${name}=).*$|\\1${value}|' ${props_file}",
        unless  => "grep -q '^${name}=${value}$' ${props_file}",
        user    => 'teamcity',
        group   => 'teamcity',
        require => [
            Class['autofs'],
            Class['jetbrains::teamcity::agent'],
        ],
    }

}
