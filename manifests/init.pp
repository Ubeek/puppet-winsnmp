#
# Manages the SNMP service under Windows.
#
### Parameters
#
#### communities
# Array of valid SNMP Community strings. Defaults to none.
#
#### contact
# The value of the 'sysContact' object. Defaults to none.
#
#### location
# The value of the 'sysLocation' object. Defaults to none.
#
#### services
# The value of the 'sysServices' object. Defaults to 76, which is also the
# default as installed by the Windows feature.
#
### Examples
#
# ```puppet
# include winsnmp
#
# class { 'winsnmp':
#   communities = ['public','private'],
#   contact     = 'admin@example.com',
#   location    = 'Data Center 1',
#   services    = 72,
# }
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
class winsnmp (
  $communities = [],
  $contact     = '',
  $location    = '',
  $services    = 76,
) {
  validate_array($communities)

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
  winsnmp::community { [$communities]: }

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
