#! /bin/bash
#include INTEL_LICENSE.txt
#
########################################################################
#
# Disable Ping Of Death
#
########################################################################
#
# DESCRIPTION
#
# The disable_pod function turns off the pod syscntl
#
# HISTORY
#
# May 17, 2003    -   Paul Brett <paul.brett@intel.com>
#                     Initial version based on the work of 
#                     Robert Adams <robert.adams@intel.com> and EMULAB
#

function disable_pod()
{
    local SYSCTL=/sbin/sysctl
    $SYSCTL -w net.ipv4.icmp_ipod_enabled=0 >/dev/null
    return 0
}


