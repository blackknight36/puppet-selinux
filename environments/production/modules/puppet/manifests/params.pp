# modules/puppet/manifests/params.pp
#
# == Class: puppet::params
#
# Parameters for the puppet puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#   John Florian <john.florian@dart.biz>
#   Michael Watters <michael.watters@dart.biz>


class puppet::params {

    $puppet_admins = hiera('puppet_admins')

    case $::operatingsystem {

        'Fedora': {

            ## Client ##
            # Apparently the brilliant packagers at puppetlabs have no clue
            # what stability means or why it's a good thing.  See:
            # https://tickets.puppetlabs.com/browse/PUP-1200
            if $::operatingsystemrelease >= '19' and
               versioncmp($puppetversion, '3.1.1') >= 0 and
               versioncmp($puppetversion, '3.4.0') < 0 {
                $client_services = [
                    'puppetagent',
                ]
            } else {
                $client_services = [
                    'puppet',
                ]
            }
            $client_packages = [
                'puppet',
            ]

            ## Database ##
            # Presently $db_packages are not shipped with Fedora, thus it is
            # necessary to configure the PuppetLabs FOSS repo as per:
            # http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html#open-source-repositories
            $db_packages = [
                'puppetdb',
                'puppetdb-terminus',
            ]
            $db_services = [
                'puppetdb',
            ]

            ## Server ##
            if $::fqdn =~ /^mdct-puppet-f(\d+)/ or $::fqdn == 'mdct-puppetmaster.dartcontainer.com' {
                $is_puppet_master = true
            }

            $server_services = [
                'puppetmaster',
            ]
            $server_packages = [
                'puppet-server',
            ]

            ## Tools ##
            $tools_packages = [
                'puppet-tools',
            ]

            $puppet_conf_dir = '/etc/puppet'
            $puppet_code_dir = '/etc/puppet'
            $puppet_ssl_dir  = '/var/lib/puppet/ssl'
        }

        'CentOS': {

            $basearch = $::architecture

            package {'puppetlabs-release-pc1':
                ensure   => installed,
                provider => 'rpm',
                source   => 'https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
            } ->

            yumrepo {'puppetlabs-pc1':
                enabled => 1,
            }
              
            package {'epel-release':
                ensure => installed,
            } ->

            # Due to https://tickets.puppetlabs.com/browse/PUP-723 we must specify all repo attributes to avoid
            # having the repo file truncated
            yumrepo {'epel':
                descr          => "Extra Packages for Enterprise Linux 7 - ${basearch}",
                mirrorlist     => "https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=${basearch}",
                failovermethod => 'priority',
                enabled        => '1',
                gpgcheck       => '1',
                gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7',
                exclude        => 'puppet*',
            }

            ## Server ##
            if $::fqdn =~ /^mdct-puppet-f(\d+)/ or $::fqdn == 'mdct-puppetmaster.dartcontainer.com' {
                $is_puppet_master = true
            }

            $server_packages = [
                'puppetserver',
                'puppetdb-termini',
            ]

            $server_services = [
                'puppetserver',
            ]

            $client_packages = [ 'puppet-agent' ]
            $client_services = [ 'puppet' ]

            $db_packages = [
                'puppetdb',
                'puppetdb-terminus',
            ]

            $db_services = [
                'puppetdb',
            ]

            group { 'puppet':
                ensure => present,
                gid    => 52,
            }

            $puppet_conf_dir = '/etc/puppetlabs/puppet'
            $puppet_code_dir = '/etc/puppetlabs/code'
            $puppet_ssl_dir  = "${puppet_conf_dir}/ssl"
        }
                        
        default: {
            fail ("${module_name} is not supported on ${::operatingsystem}.")
        }

    }

}
