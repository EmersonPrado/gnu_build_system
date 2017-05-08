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

> So far, it only installs `gcc` and `make` packages and runs `./configure`. `make` is not implemented yet.

> Be advised that this kind of installation is considered a Bad Thing when using a configuration manager like Puppet. See [here](https://ask.puppet.com/question/23/how-can-i-use-puppet-to-build-from-source/), [here](https://superuser.com/questions/415047/install-a-source-package-with-puppet) and [here](http://stackoverflow.com/questions/41425506/using-puppet-to-build-from-source) for some opinions. Use this module as a last resort.

## Setup

### What gnu_build_system affects

gnu_build_system installs `gcc` and `make` packages. By `gcc` packages, it means the whole set of packages required for compilation in your OS.

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

This section is where you describe how to customize, configure, and do the
fancy stuff with your module here. It's especially helpful if you include usage
examples and code samples for doing things with your module.

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

## Limitations

This is where you list OS compatibility, version compatibility, etc. If there
are Known Issues, you might want to include them under their own heading here.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Contributors

The list of contributors can be found [here](https://github.com/EmersonPrado/gnu_build_system/graphs/contributors)
