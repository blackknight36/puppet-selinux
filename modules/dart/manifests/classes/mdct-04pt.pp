# modules/dart/manifests/classes/mdct-04pt.pp

class dart::mdct-04pt inherits dart::picaps_test_node {

    # needed until puppet bugs with module facts resolved
    $tzname = 'America/Chicago'

}
