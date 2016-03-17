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

    # Bacula
    $bacula_dir_sd_target   = 'localhost'
    $bacula_dir_fqdn        = 'mdct-00bk.dartcontainer.com'
    $bacula_dir_name        = 'mdct-bacula-dir'
    $bacula_dir_passwd      = 'egw444LCYCMTHcR2wefPkzlTer0QIU84PHcU0Uv0b8PN'
    $bacula_mon_name        = 'mdct-bacula-mon'
    $bacula_mon_passwd      = 'Mzdhf6ZMzWtevWY7xwRQUFVIjs2t2tCSqpw9WdNGQrtG'
    $bacula_sd_fqdn         = 'mdct-00bk.dartcontainer.com'
    $bacula_sd_name         = 'mdct-bacula-sd'
    $bacula_sd_passwd       = 'oPm5LiIU7n77WlEFAnZPA0gmINQA5fyJxmBvULOuof5C'
    $bacula_team            = 'john.florian@dart.biz,levi.harper@dart.biz,chris.pugh@dart.biz,ben.minshall@dart.biz,nathan.nephew@dart.biz,elizabeth.scott@dart.biz,kristina.doyle@dart.biz'

    # SMTP
    $smtp_server = hiera('smtp_server', 'smtp.dartcontainer.com')

}
