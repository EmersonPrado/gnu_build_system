# Defined type gnu_build_system::configure
#
# Runs './configure' in a given directory
#
# Parameters
#
# path (string)
#   Directory where ./configure should be executed
#   Default => resource title
#     > The path to the directory containing 'configure',
#     > not to 'configure' executable itself
#
# opts (array of strings)
#   Command-line options for ./configure
#   Default => none
#
# vars (array of strings)
#   Command-line variables for ./configure
#   Default => none
#
# user (string)
#   User which executes ./configure
#   Default => User running Puppet agent (typically root)
#
# group (string)
#   Group which executes ./configure
#   Default => Group running Puppet agent (typically root)
#
# Examples
# --------
#
# @example - Runs ./configure without options or variables
#   gnu_build_system::configure { '/home/cliff_burton/src/x_speed': }
#
# @example - Runs ./configure specifying an option and some variables
#   gnu_build_system::configure { 'bernoulli':
#     path => '/home/ada_lovelace/easy_stuff/bernoulli',
#     opts => ['--quiet'],
#     vars => [
#       '--prefix=/opt/bernoulli/noarch',
#       '--exec-prefix=/opt/bernoulli/amd64',
#     ],
#   }
#
# @example - Runs ./configure with different user and group
#   gnu_build_system::configure { '/tmp/shrubbery':
#     user  => 'head_knight',
#     group => 'knights_of_ni',
#   }
#
# Authors
# -------
#
# Emerson Prado <emerson.prado.eng@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2017 Emerson Prado.
#
define gnu_build_system::configure (
  $path  = $title,
  $opts  = [],
  $vars  = [],
  $user  = undef,
  $group = undef,
) {

  $command = join(concat(['configure'], $opts, $vars), ' ')

  exec { "${path}/configure":
    command => $command,
    cwd     => $path,
    user    => $user,
    group   => $group,
    path    => ['/bin','/usr/bin',$path],
    unless  => 'test Makefile -nt configure',
  }

}
