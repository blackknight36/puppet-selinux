# == Class: bacula::params
#
# Default values for parameters needed to configure the <tt>bacula</tt> class.
#
# === Parameters
#
# None
#
# === Examples
#
#  include ::bacula::params
#
# === Copyright
#
# Copyright 2012 Russell Harrison
#
# === License
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
class bacula::params {
  if $::osfamily == 'RedHat' and versioncmp($::operatingsystemmajrelease, '7') >= 0 {
    $bat_console_package         = 'bacula-console-bat'
    $director_mysql_package      = 'bacula-director'
    $director_postgresql_package = 'bacula-director'
    $director_sqlite_package     = 'bacula-director'
    $storage_mysql_package       = 'bacula-storage'
    $storage_postgresql_package  = 'bacula-storage'
    $storage_sqlite_package      = 'bacula-storage'
  }
  elsif $::osfamily == 'Debian' {
    $bat_console_package         = 'bacula-console-qt'
    $director_mysql_package      = 'bacula-director-mysql'
    $director_postgresql_package = 'bacula-director-pgsql'
    $director_sqlite_package     = 'bacula-director-sqlite'
    $storage_mysql_package       = 'bacula-sd-mysql'
    $storage_postgresql_package  = 'bacula-sd-pgsql'
    $storage_sqlite_package      = 'bacula-sd-sqlite'
  }
  else {
    $bat_console_package         = 'bacula-console-bat'
    $director_mysql_package      = 'bacula-director-mysql'
    $director_postgresql_package = 'bacula-director-postgresql'
    $director_sqlite_package     = 'bacula-director-sqlite'
    $storage_mysql_package       = 'bacula-storage-mysql'
    $storage_postgresql_package  = 'bacula-storage-postgresql'
    $storage_sqlite_package      = 'bacula-storage-sqlite'
  }

  $console_package             = 'bacula-console'
  $director_server_default     = "bacula.${::domain}"
  $director_service            = $::operatingsystem ? {
    /(Debian|Ubuntu)/ => 'bacula-director',
    default           => 'bacula-dir',
  }
  $lib    = $::architecture ? {
    x86_64  => 'lib64',
    default => 'lib',
  }
  $libdir = $::operatingsystem ? {
    /(Debian|Ubuntu)/ => '/usr/lib',
    default           => "/usr/${lib}",
  }
  $mail_to_default             = "root@${::fqdn}"
  $manage_logwatch = $::operatingsystem ? {
    /(Debian|Ubuntu)/ => false,
    default           => true,
  }
  $plugin_dir           = "${libdir}/bacula"
  $storage_server_default      = "bacula.${::domain}"
}
