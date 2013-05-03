#!/bin/bash
# vim: smarttab expandtab ts=4 sw=4

usage() {
    cat <<EOF
Usage:   $0 <buildnumber> 
Example: $0 2493 
Example: $0 2493
EOF
}

if [ $# -lt 1 ]
then
    usage
    exit 1
fi

build="$1"

. /etc/sysconfig/picaps

${JAVA_HOME}/bin/java \
    -DResourceFactoryClass=com.dartcontainer.mdc.picaps.PicapsResourceFactory \
    -Dbuild=$build \
    -jar /dist/Picaps-$build.jar \
    com.dartcontainer.mdc.picaps.util.InitializeDatabase \
    -h localhost
