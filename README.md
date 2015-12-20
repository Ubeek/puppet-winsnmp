#winsnmp

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with winsnmp](#setup)
    * [What winsnmp affects](#what-winsnmp-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with winsnmp](#beginning-with-winsnmp)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

Manages SNMP configuration under Windows.

##Module Description

This module installs the SNMP service and manages its configuration. This
includes setting community strings and the standard RFC1156 objects.

##Setup

###What winsnmp affects

* The `SNMP` feature and the corresponding service.
* Registry keys managing configuration of the above.

###Setup Requirements

The following third party modules must be installed:

* puppetlabs/dism
* puppetlabs/registry
* puppetlabs/stdlib

###Beginning with winsnmp

To use the module with its defaults, simply include the `winsnmp` class.

```puppet
include winsnmp
```

##Usage

A more advanced configuration, with community strings and standard RFC1156
objects looks something like the below.

```puppet
class { 'winsnmp':
  r_communities => ['public','another_public'],
  w_communities => ['private','secret'],
  contact       => 'admin@example.com',
  location      => 'Data Center 1',
  services      => 72,
}
```

##Reference

###Class `winsnmp`

Installs and configures SNMP.

####Parameters

#####`r_communities`
Array of valid Read-Only SNMP Community strings. Defaults to none.

#####`w_communities`
Array of valid Write SNMP Community strings. Defaults to none.

#####`communities`
Array of valid Read-Only SNMP Community strings. Defaults to none. Deprecated, can not be used in conjunction with 'r_communities'.

#####`contact`
The value of the RFC1156 `sysContact` object. Defaults to none.

#####`location`
The value of the RFC1156 `sysLocation` object. Defaults to none.

#####`services`
The value of the RFC1156 `sysServices` object. Defaults to 76, which is also
the default as installed by the Windows feature.

#####`purge`
Boolean to determine if current SNMP values (PermittedManagers, ValidCommunities or RFC1156Agent) should be removed. Defaults to 'true'.

###Define `winsnmp::community`

Manages a single SNMP community string. This is usually done via the main
`winsnmp` class.

####Parameters

#####`community`
The SNMP community string. Defaults to the resource title.

#####`security`
The permission level on the SNMP community string. Accepts 'READ', 'WRITE' or 'NONE'. Defaults to 'READ'.


###Define `winsnmp::object`

Manages a single RFC1156 object. The standard objects `sysContact`,
`sysLocation` and `sysServices` may be managed via the main `winsnmp` class.

####Parameters

#####`object`
The name of the object. Defaults to resource title.

#####`type`
The data type of the object. This value is passed as the `type` parameter
of a `registry_value` resource. The default is `string`. See documentation
at http://forge.puppetlabs.com/puppetlabs/registry for details.

#####`value`
The value the object should contain (required).


##Limitations

This module has been tested on Windows 2008 R2, but may well work on other
versions.

##Development

For fixes, improvements, etc, please see our project page:
https://github.com/sanoma-technology/puppet-winsnmp

##Release Notes/Contributors/Etc

This space intentionally left blank.
