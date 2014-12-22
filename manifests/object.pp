# == Define: winsnmp::object
#
# Configure an RFC1156 object on Windows SNMP installations.
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
define winsnmp::object (
  $value,
  $object = $title,
  $type   = 'string',
) {
  $path = 'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\RFC1156Agent'

  registry_value { "${path}\\${object}":
    ensure => present,
    type   => $type,
    data   => $value,
    notify => Service[$winsnmp::service],
  }
}
