# modules/dart/manifests/classes/mole.pp

class dart::mole inherits dart::abstract::workstation_node {

    include postgresql::server

}
