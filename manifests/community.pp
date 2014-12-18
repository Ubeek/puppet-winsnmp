#
# Configure an SNMP community on Windows installations.
#
### Parameters
#
#### community
# The SNMP community string. Defaults to resource title.
#
### Examples
#
# ```puppet
# winsnmp::community{ 'public': }
# ```
#
### Authors
#
# * Steve Maddison <steve.maddison@sanoma.com>
#
### Copyright
#
# Copyright 2014 Sanoma Digital
#
define winsnmp::community (
  $community = $title,
) {
  $path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\ValidCommunities'

  registry_value { "${path}\\${community}":
    ensure => present,
    type   => 'dword',
    data   => '4',
    notify => Service[$winsnmp::service],
  }
}
