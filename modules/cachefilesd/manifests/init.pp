# /etc/puppet/modules/cachefilesd/manifests/init.pp

class cachefilesd {

    # Support pre-F13 was weak, so don't bother there.
    if $operatingsystem == "Fedora" and $operatingsystemrelease >= 13 {

        package { "cachefilesd":
            ensure  => installed,
        }

        file { "/etc/cachefilesd.conf":
            group   => "root",
            mode    => "0640",
            owner   => "root",
            require => Package["cachefilesd"],
            source  => $selinux ? {
                "false" => "puppet:///modules/cachefilesd/cachefilesd.conf-sel-disabled",
                default => "puppet:///modules/cachefilesd/cachefilesd.conf",
            },
        }

        service { "cachefilesd":
            enable      => $hostname ? {
                #"mdct-dev10"    => false,
                #"mdct-dev12"    => false,
                default         => false,
            },
            ensure      => $hostname ? {
                #"mdct-dev10"    => stopped,
                #"mdct-dev12"    => stopped,
                default         => stopped,
            },
            hasrestart  => true,
            hasstatus   => true,
            require             => [
                Package["cachefilesd"],
            ],
            subscribe   => [
                File["/etc/cachefilesd.conf"],
            ],
        }

    }

}
