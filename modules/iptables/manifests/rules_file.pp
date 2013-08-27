# modules/iptables/manifests/rules_file.pp
#
# Synopsis:
#       Installs a custom iptables rules file via lokkit.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       ensure          1       one of: 'present' or 'absent'
#
#       source                  origin of custom rules file
#
#       type            2       one of: 'ipv4' or 'ipv6'
#
#       table           3       netfilter table to be affected
#
# Notes:
#
#       1. Default is 'present'.
#
#       2. Default is 'ipv4'.
#
#       3. Default is 'filter'.


define iptables::rules_file ($ensure='present', $source, $type='ipv4',
                           $table='filter') {

    if $iptables::managed_host == true {

        case $ensure {

            'absent': {
                # The lokkit executable itself lacks this feature.
                fail('Removal of custom rules is not yet supported.')
            }

            'present': {

                $rules_file="/etc/sysconfig/iptables.${name}"

                file { "${rules_file}":
                    owner   => 'root',
                    group   => 'root',
                    mode    => '0600',
                    seluser => 'system_u',
                    selrole => 'object_r',
                    seltype => 'system_conf_t',
                    require => Class['iptables'],
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

    } else {
        notice("iptables management is disabled on $fqdn via \$iptables::managed_host.")
    }

}
