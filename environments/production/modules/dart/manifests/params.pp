# modules/dart/manifests/params.pp
#
# == Class: dart::params
#
# Commonly used domain-level parameters for Dart Container.
#
# NOTICE:
#
#   DO NOT ADD ANY MORE VALUES HERE.  PLEASE ADD THEM TO HIERA INSTEAD.
#
#   This class is deprecated and slated for eventual removal.


class dart::params {

    # Bacula settings
    $bacula_dir_sd_target = hiera('bacula_dir_sd_target')
    $bacula_dir_fqdn      = hiera('bacula_dir_fqdn')
    $bacula_dir_name      = hiera('bacula_dir_name')
    $bacula_dir_passwd    = hiera('bacula_dir_passwd')
    $bacula_mon_name      = hiera('bacula_mon_name')
    $bacula_mon_passwd    = hiera('bacula_mon_passwd')
    $bacula_sd_fqdn       = hiera('bacula_sd_fqdn')
    $bacula_sd_name       = hiera('bacula_sd_name')
    $bacula_sd_passwd     = hiera('bacula_sd_passwd')
    $bacula_team          = join(hiera('bacula_team'), ',')

    # SMTP
    $smtp_server = hiera('smtp_server', 'smtp.dartcontainer.com')

}
