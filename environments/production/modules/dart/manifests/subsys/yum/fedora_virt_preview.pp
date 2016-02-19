# modules/dart/manifests/subsys/yum/fedora_virt_preview.pp

class dart::subsys::yum::fedora_virt_preview {

    include 'dart::subsys::yum::params'

    # Rawhide systems begin life as the latest stable release and should be
    # fully puppetized prior to upgrading to rawhide.  Once there, they have
    # no need for this section, which would only throw errors anyway.
    if $::operatingsystemrelease != 'Rawhide' {

        yum::repo_file {'fedora-virt-preview.repo':
            source  => 'puppet:///modules/dart',
        }

    }

}
