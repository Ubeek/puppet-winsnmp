# == Class: winsnmp
#
# Manages the SNMP service under Windows.
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
class winsnmp (
  $communities    = [],
  $r_communities  = [],
  $w_communities  = [],
  $contact        = '',
  $location       = '',
  $services       = 76,
) {
  validate_array($communities)
  validate_array($r_communities)
  validate_array($w_communities)

  if empty($r_communities) {$r_communities = $communities}

  $feature = 'SNMP'
  $service = 'snmp'

  dism { $feature:
    ensure => present,
  }

  service { $service:
    ensure  => running,
    require => Dism[$feature],
  }

  # Ensure required keys are present and that they only contain our values.
  registry_key { [
    'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\PermittedManagers',
    'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\RFC1156Agent',
    'HKLM\SYSTEM\CurrentControlSet\services\SNMP\Parameters\ValidCommunities' ]:
    purge_values => true,
    require      => Dism[$feature],
    notify       => Service[$service],
  }

  # Configure all necessary community strings.
  #winsnmp::community { [$communities]: }
  winsnmp::community { [$r_communities]: security => 'READ',}
  winsnmp::community { [$w_communities]: security => 'WRITE',}

  # Set the standard RFC1156 objects.
  if $contact {
    winsnmp::object { 'sysContact':
      value => $contact,
    }
  }
  if $location {
    winsnmp::object { 'sysLocation':
      value => $location,
    }
  }
  if $services {
    winsnmp::object { 'sysServices':
      type  => 'dword',
      value => $services,
    }
  }
}
