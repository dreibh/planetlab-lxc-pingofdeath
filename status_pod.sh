#!/bin/bash 

function status_pod()
{

    local SYSCTL="/sbin/sysctl"

    # Check that IPOD is built into this kernel
    local version
    version=`$SYSCTL -n net.ipv4.icmp_ipod_version 2> /dev/null`
    if [[ $? -ne 0 ]]
    then
        echo "Not installed"
        return 255
    fi

    # Check if it has been enabled
    local enabled=`$SYSCTL -n net.ipv4.icmp_ipod_enabled`
    echo -n "version $version "
    if [[ $enabled -eq 1 ]]
    then 
        echo "Enabled"
    else 
        echo "Disabled"
    fi
    return $enabled
}
