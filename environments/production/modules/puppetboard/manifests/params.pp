# == Class: puppetboard::params
#
# Defines default values for puppetboard parameters.
#
# Inherited by Class['puppetboard'].
#
class puppetboard::params {

  case $::osfamily {
    'Debian': {
        $apache_confd   = '/etc/apache2/conf.d'
        $apache_service = 'apache2'
    }
    'RedHat': {
        $apache_confd   = '/etc/httpd/conf.d'
        $apache_service = 'httpd'
    }
    default: { fail("The ${::osfamily} operating system is not supported with the puppetboard module") }
  }

  $user  = 'puppetboard'
  $group = 'puppetboard'
  $groups = undef
  $basedir = '/srv/puppetboard'
  $git_source = 'https://github.com/puppet-community/puppetboard'

  $puppetdb_host = 'localhost'
  $puppetdb_port = 8080
  $puppetdb_key = "/srv/puppetboard/ssl/private_keys/${::fqdn}.pem"
  $puppetdb_cert = "/srv/puppetboard/ssl/certs/${::fqdn}.pem"
  $puppetdb_ssl_verify = false
  $puppetdb_timeout = 20
  $dev_listen_host = '127.0.0.1'
  $dev_listen_port = 5000
  $unresponsive = 3
  $enable_query = true
  $localise_timestamp = true
  $python_loglevel = 'info'
  $python_proxy = false
  $reports_count = '10'
  $experimental = false
  $revision = undef
  $virtualenv = 'python-virtualenv'
  $listen = 'private'
  $wsgi_alias = '/'
  $wsgi_threads = '5'
  $wsgi_max_reqs = '0'
  $docroot = "${basedir}/puppetboard"
  $extra_settings = { 'GRAPH_FACTS' => "operatingsystem, rubyversion", }

  $pip_packages = [
    'Flask',
    'Flask-WTF',
    'Jinja2',
    'MarkupSafe',
    'WTForms',
    'Werkzeug',
    'itsdangerous',
    'pypuppetdb',
    'requests',
    ]
}
