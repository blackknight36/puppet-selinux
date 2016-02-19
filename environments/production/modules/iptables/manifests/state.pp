# modules/iptables/manifests/state.pp
#
# == Class: iptables::state
#
# Manage the runtime state of iptables, such as after manipulating the
# configuration files via the half brain-dead lokkit tool.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class iptables::state {

    include 'iptables::params'

    exec { 'lokkit --update':
        refreshonly => true,
    }

}
