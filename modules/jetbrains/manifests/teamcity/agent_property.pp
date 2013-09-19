# modules/jetbrains/manifests/teamcity/agent_property.pp
#
# Synopsis:
#       Configures a single, specific JetBrains TeamCity Build Agent property.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    property name
#
#       value                   value that property is to take
#
#       props_file              path to Build Agent's configuration properties


define jetbrains::teamcity::agent_property ($props_file, $value) {

    include 'jetbrains::teamcity::agent'

    exec { "configure-${name}":
        command => "sed -ri 's|^(${name}=).*$|\1${value}|' ${props_file}",
        unless  => "grep -q '^${name}=${value}$' ${props_file}",
        user    => 'teamcity',
        group   => 'teamcity',
        require => [
            Class['autofs'],
            Class['jetbrains::teamcity::agent'],
        ],
    }

}
