# modules/lokkit/manifests/rules_file.pp
#
# Synopsis:
#       Installs a custom iptables rules file via lokkit.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       name                            instance name
#       ensure          present         present/absent
#       source                          origin of custom rules file
#       type            ipv4            protocol type: "ipv4" or "ipv6"
#       table           filter          netfilter table to be affected
#
# Requires:
#       Class['iptables']
#       Class['lokkit']
#
# Example usage:
#
#       include lokkit
#
#       lokkit::tcp_port { 'ssh':
#           ensure  => 'open',
#           port    => '22',
#       }


define lokkit::rules_file ($ensure='present', $source, $type='ipv4',
                           $table='filter') {

    if $lokkit_disabled == 'true' {
        info('Disabled via $lokkit_disabled.')
    } else {

        case $ensure {

            'absent': {
                # The lokkit executable itself lacks this feature.
                fail('Removal of custom rules is not yet supported.')
            }

            'present': {

                $rules_file="/etc/sysconfig/iptables.${name}"

                file { "${rules_file}":
                    group   => 'root',
                    mode    => '0600',
                    owner   => 'root',
                    require => Class['iptables'],
                    seluser => 'system_u',
                    selrole => 'object_r',
                    seltype => 'system_conf_t',
                    source  => "${source}",
                }

                exec { "add-rules-${name}":
                    command => "lokkit --custom-rules=${type}:${table}:${rules_file}",
                    unless  => "grep -q -- '^--custom-rules=${type}:${table}:${rules_file}' /etc/sysconfig/system-config-firewall",
                    require => File["${rules_file}"],
                }
            }

            default: {
                fail('$ensure must be either "absent" or "present".')
            }

        }

    }

}
