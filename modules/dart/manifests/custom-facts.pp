# modules/dart/manifests/custom-facts.pp
#
# Synopsis:
#       Custom facts used for Dart.
#
# Notice:
#       The facter::custom-fact is a kludge.  See the definition for details
#       and advice for avoiding it.

class dart::custom-facts {

    facter::custom-fact { "plant_number":
        # This is sort of a reverse-dependency and is coded this way because
        # there's no way to say that a class requires this custom-fact.  At
        # the resource type level (within a class), it's too late -- many
        # variables our accessed as conditional wrappers around those resource
        # types.  It is a class dependency!
        before => [
            Class['timezone'],
        ],
        source => 'puppet:///modules/dart/facter/plant_number.rb',
    }

}
