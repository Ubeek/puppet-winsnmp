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
  $security  = '',
) {
  $path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\ValidCommunities'

  case $security {
    'WRITE': {
      $reg_value = '8'
    }
    'READ': {
      $reg_value = '4'
    }
    'NONE': {
      $reg_value = '1'
    }
    default: {
      $reg_value = '4'
    }
  }

  registry_value { "${path}\\${community}":
    ensure => present,
    type   => 'dword',
    data   => $reg_value,
    notify => Service[$winsnmp::service],
  }
}
