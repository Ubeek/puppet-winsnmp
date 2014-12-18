# == Define: winsnmp::community
#
# Configure an SNMP community on Windows installations.
#
# See `README.md` for more details.
#
# === Authors
#
# * Steve Maddison <steve.maddison@sanoma.com>
#
# === Copyright
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
