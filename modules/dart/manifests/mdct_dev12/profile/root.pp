# modules/dart/manifests/mdct_dev12/profile/root.pp
#
# == Class: dart::mdct_dev12::profile::root
#
# Manages a bunch of profile-like resources for the root user on John
# Florian's workstation.
#
# === Parameters
#
# ==== Required
#
# [* git_proxy *]
#   The proxy that git is to use, for those configurations which require one.
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_dev12::profile::root (
        $git_proxy,
    ) {

    sendmail::alias { 'root':
        recipient   => 'john.florian@dart.biz',
    }

    # Make root user source my prophile by default.
    exec { 'prophile-install -f jflorian':
        require => Package['prophile'],
        unless  => 'grep -q prophile /root/.bash_profile',
    }

    File {
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
    }

    file {
        '/root/.gvimrc_site':
            source  => 'puppet:///modules/dart/mdct-dev12/gvimrc_site',
            ;

        '/root/.gitconfig':
            content => template('dart/mdct-dev12/git/gitconfig'),
            ;

        '/root/.gitignore':
            source  => 'puppet:///modules/dart/mdct-dev12/git/gitignore',
            ;
    }

}
