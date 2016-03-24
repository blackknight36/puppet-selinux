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
            if $::fqdn =~ /^mdct-puppet-f(\d+)/ or $::fqdn == 'mdct-dev27-puppetmaster.dartcontainer.com' {
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
        }

        'CentOS': {

            yumrepo {'epel': 
                exclude => 'puppet*',
            } ->

            package {'puppetlabs-release-pc1':
                ensure => installed,
                provider => 'rpm',
                source => 'https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
            } ->

            yumrepo {'puppetlabs-pc1' :
                enabled => 1,
            }
              
            ## Server ##
            if $::fqdn =~ /^mdct-puppet-f(\d+)/ or $::fqdn == 'mdct-dev27-puppetmaster.dartcontainer.com' {
                $is_puppet_master = true
            }

            $server_packages = [
                'puppetserver',
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
        }
                        
        default: {
            fail ("${module_name} is not supported on $::operatingsystem.")
        }

    }

}
