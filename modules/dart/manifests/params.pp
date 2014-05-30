# modules/dart/manifests/params.pp
#
# == Class: dart::params
#
# Commonly used domain-level parameters for Dart Container.


class dart::params {

    # Bacula
    $bacula_dir_sd_target   = 'localhost'
    $bacula_dir_fqdn        = '10.1.31.30'  # TODO: 'mdct-00bk.dartcontainer.com'
    $bacula_dir_name        = 'mdct-bacula-dir'
    $bacula_dir_passwd      = 'egw444LCYCMTHcR2wefPkzlTer0QIU84PHcU0Uv0b8PN'
    $bacula_mon_name        = 'mdct-bacula-mon'
    $bacula_mon_passwd      = 'Mzdhf6ZMzWtevWY7xwRQUFVIjs2t2tCSqpw9WdNGQrtG'
    $bacula_sd_fqdn         = '10.1.31.30'  # TODO: 'mdct-00bk.dartcontainer.com'
    $bacula_sd_name         = 'mdct-bacula-sd'
    $bacula_sd_passwd       = 'oPm5LiIU7n77WlEFAnZPA0gmINQA5fyJxmBvULOuof5C'

    # DNS
    $dns_domain     = $domain
    $dns_servers    = ['10.1.0.98', '10.1.0.99']

}
