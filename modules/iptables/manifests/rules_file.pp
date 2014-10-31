# modules/iptables/manifests/rules_file.pp
#
# == Define: iptables::rules_file
#
# Installs a custom iptables rules file via lokkit.
#
# === Parameters
#
# [*namevar*]
#   An arbitrary identifier for the rules_file instance.  The resultant file
#   will be named "/etc/sysconfig/iptables.${name}".
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.  Note that the lokkit
#   executable lacks the features needed to implement an 'absent' sense.
#
# [*content*]
#   Literal content for the rules file file.  One and only one of "content" or
#   "source" must be given.
#
# [*source*]
#   URI of the rules file file content.  One and only one of "content" or
#   "source" must be given.
#
# [*type*]
#   One of: 'ipv4' (the default) or 'ipv6'.
#
# [*table*]
#   The netfilter table to be affected.  Defaults to 'filter'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   John Florian <jflorian@doubledog.org>


define iptables::rules_file (
        $ensure='present',
        $content=undef,
        $source=undef,
        $type='ipv4',
        $table='filter',
    ) {

    include 'iptables::state'

    if $iptables::managed_host == true {

        case $ensure {

            'absent': {
                # The lokkit executable itself lacks this feature.
                fail('Removal of custom rules is not yet supported')
            }

            'present': {

                $rules_file="/etc/sysconfig/iptables.${name}"

                file { $rules_file:
                    owner   => 'root',
                    group   => 'root',
                    mode    => '0600',
                    seluser => 'system_u',
                    selrole => 'object_r',
                    seltype => 'system_conf_t',
                    require => Class['iptables'],
                    content => $content,
                    source  => $source,
                    notify  => Class['iptables::state'],
                }

                exec { "add-rules-${name}":
                    command => "lokkit --custom-rules=${type}:${table}:${rules_file}",
                    unless  => "grep -q -- '^--custom-rules=${type}:${table}:${rules_file}' /etc/sysconfig/system-config-firewall",
                    require => File[$rules_file],
                }

            }

            default: {
                fail('$ensure must be either "absent" or "present".')
            }

        }

    } else {
        notice("iptables management is disabled on ${::fqdn} via \$iptables::managed_host.")
    }

}
