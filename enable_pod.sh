#! /bin/bash
#include INTEL_LICENSE.txt
#
########################################################################
#
# Enable Ping Of Death
#
########################################################################
#
# DESCRIPTION
#
# The Enable_POD function is passed the IP_SUBNET, IP_MASK and HASH and
# does all the dirty muching about with syscontrols
#
# HISTORY
#
# May 17, 2003    -   Paul Brett <paul.brett@intel.com>
#                     Initial version based on the work of 
#                     Robert Adams <robert.adams@intel.com> and EMULAB
#

function enable_pod()
{
    local SYSCTL=/sbin/sysctl

    local IP_SUBNET=$1
    local IP_MASK=$2
    local IP_HASH=$3

    # Grotesque sed/awk converts IP addrs into an integer for sysctl
    local IPODHOST=`echo $IP_SUBNET | \
              sed -e 's/\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\).*/\1 \2 \3 \4/' | \
              awk '{ printf "%d\n", $1*16777216+$2*65536+$3*256+$4 }'`
    local IPODMASK=`echo $IP_MASK | \
              sed -e 's/\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\).*/\1 \2 \3 \4/' | \
              awk '{ printf "%d\n", $1*16777216+$2*65536+$3*256+$4 }'`
    local IPODKEY=`echo $HASH | \
              sed -e 's/\(.*\)/\1/'`

    # figure out the version
    local version=`$SYSCTL net.ipv4.icmp_ipod_version 2>/dev/null`
    if [[ "$version" == "" ]]
    then
        $SYSCTL net.ipv4.icmp_ipod_enabled >/dev/null 2>&1
        case $? in
            0)
                version=1
                ;;
            *)
                version=0
                ;;
        esac
    fi

    # enable if possible
    case $version in
        0)
            return 1
            ;;
        1)
            $SYSCTL -w net.ipv4.icmp_ipod_host=$IPODHOST >/dev/null
            $SYSCTL -w net.ipv4.icmp_ipod_enabled=1 >/dev/null
            Success=0
            ;;
        *)
            $SYSCTL -w net.ipv4.icmp_ipod_host=$IPODHOST >/dev/null
            Success=$?
            $SYSCTL -w net.ipv4.icmp_ipod_mask=$IPODMASK >/dev/null
            $SYSCTL -w net.ipv4.icmp_ipod_key=$IPODKEY >/dev/null
            $SYSCTL -w net.ipv4.icmp_ipod_enabled=1 >/dev/null
        ;;
    esac
    return $Success
}


