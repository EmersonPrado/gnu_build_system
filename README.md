# gnu_build_system

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with gnu_build_system](#setup)
    * [What gnu_build_system affects](#what-gnu_build_system-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with gnu_build_system](#beginning-with-gnu_build_system)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Manages packages created in the GNU Build System with Puppet. That is: install stuff by the good old `./configure` and `make <target>` sequence.

This module aims to replace a tedious series of `exec`s needed if one is managing packages from "tarballs" and such.

> Still uses `exec` resource. I hope to get it right and have custom types in the future.

> Be advised that this kind of installation is considered a **Bad Thing** when using a configuration manager like Puppet. See [here](https://ask.puppet.com/question/23/how-can-i-use-puppet-to-build-from-source/), [here](https://superuser.com/questions/415047/install-a-source-package-with-puppet) and [here](http://stackoverflow.com/questions/41425506/using-puppet-to-build-from-source) for some opinions. Use this module as a last resort.

## Setup

### What gnu_build_system affects

- Installs `gcc` and `make` packages. By `gcc` packages, it means the whole set of packages required for compilation in your OS.
- Compiles and installs whatever unpacked package you run these commands on

### Setup Requirements

- OS
  - RedHat 5, 6 and 7 and derivatives
  - Debian 6 and 7 and derivatives
- Packages
  - Puppet >= 3.8.7 < 4.0.0
  - ruby
- Modules
  - [puppetlabs/stdlib](https://forge.puppet.com/puppetlabs/stdlib) (>= 4.15.0 < 5.0.0)
  - [puppetlabs/gcc](https://forge.puppet.com/puppetlabs/gcc) (>= 0.3.0 < 1.0.0)
  - [puppet/make](https://forge.puppet.com/puppet/make) (>= 1.0.0 < 2.0.0)

> Recommended module: [puppet/archive](https://forge.puppet.com/puppet/archive) - downloads and extracts compressed files, including tarballs

### Beginning with gnu_build_system

The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most
basic use of the module.

## Usage

### Installing `gcc` and `make`

Just including the main class will suffice for most cases:
```
include gnu_build_system
```

If you need to manage only `gcc` or `make`, as opposed to both packages, use `_manage` parameter to disable management of the other package:
```
class { 'gnu_build_system':
  gcc_manage  => false, # Or
  make_manage => false,
}
```

To manage packages other than the defaults, use `_package(s)` parameters:
```
class { 'gnu_build_system':
  gcc_packages => ['<Package 1>', '<Package 2>'...], # And/or
  make_package => '<Alternative make>',
}
```

> For information on default packages, pls see [gcc](https://forge.puppet.com/puppetlabs/gcc) and [make](https://forge.puppet.com/puppet/make) modules


## Reference

### class `gnu_build_system`

| Parameter    | Description                           | Type    | Default |
|--------------|---------------------------------------|---------|---------|
| gcc_manage   | Whether to install gcc packages       | Boolean | true    |
| gcc_packages | Alternative list of compiler packages | Array   | undef*  |
| make_manage  | Whether to install make package       | Boolean | true    |
| make_package | Alternative make package              | String  | undef*  |

\* - Uses typical OS packages, determined by `make` module

### Defined type `gnu_build_system::configure`

| Parameter    | Description                              | Type    | Default              |
|--------------|------------------------------------------|---------|----------------------|
| path         | Directory where to run `./configure`     | String  | Resource title       |
| opts         | Command-line options for `./configure`   | Array   | None                 |
| vars         | Command-line variables for `./configure` | Array   | None                 |
| user         | User for `./configure` execution         | String  | User running Puppet  |
| group        | Group for `./configure` execution        | String  | Group running Puppet |

### Defined type `gnu_build_system::make`

| Parameter    | Description                           | Type    | Default              |
|--------------|---------------------------------------|---------|----------------------|
| path         | Directory where to run `make`         | String  | Required             |
| opts         | Command-line options for `make`       | Array   | None                 |
| target       | `make` target                         | String  | None                 |
| creates      | Target file to check before execution | String  | None (don't check)   |
| user         | User for `make` execution             | String  | User running Puppet  |
| group        | Group for `make` execution            | String  | Group running Puppet |

## Limitations

This module is intended to run in any GNU Build System compatible Linux, but was tested in very few situations.

There is no input validation yet.

Target files timestamp checking is still done in only one file.

## Development

Pls follow general [guidelines](https://docs.puppet.com/forge/contributing.html) from Puppet Forge and Puppet [language style guide](https://docs.puppet.com/puppet/4.10/style_guide.html). Pls also run any changed code thru tools like `puppet parser validate` and `puppet-lint` and, of course, test the code.

## Contributors

The list of contributors can be found [here](https://github.com/EmersonPrado/gnu_build_system/graphs/contributors)
