# Defined type gnu_build_system::make
#
# Runs 'make' in a given directory
#
# Parameters
#
# path (string)
#   Directory where make should be executed
#   Required
#
# opts (array of strings)
#   Command-line options for make
#   Default => none
#
# target (string)
#   make target
#   Default => none
#
# user (string)
#   User which executes make
#   Default => User running Puppet agent (typically root)
#
# group (string)
#   Group which executes make
#   Default => Group running Puppet agent (typically root)
#
# Examples
# --------
#
# @example - Runs make without options or variables
#   gnu_build_system::make { 'x_speed/make':
#     path => '/home/cliff_burton/src/x_speed',
#   }
#
# @example - Runs make install silently with additional makefile directory
#   gnu_build_system::make { 'bernoulli/make install':
#     path   => '/home/ada_lovelace/easy_stuff/bernoulli',
#     opts   => ['-s', '-I /usr/src/babbage'],
#     target => 'install',
#   }
#
# @example - Runs make check with different user and group
#   gnu_build_system::make { 'shrubbery/make check':
#     path   => '/tmp/shrubbery',
#     target => 'check',
#     user   => 'head_knight',
#     group  => 'knights_of_ni',
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
define gnu_build_system::make (
  $path,
  $opts    = [],
  $target  = undef,
  $creates = undef,
  $user    = undef,
  $group   = undef,
) {

  # Shell command line
  $command = join(concat(['make'], $opts, $target), ' ')

  # If user specified target file, creates shell command line test
  # to check whether it's newer than Makefile
  if $creates == undef {
    $check = 'true'
  }
  else {
    $check = "test Makefile -nt ${creates}"
    # Updates timestamp of target file to avoid unnecessary runs
    $creates_path = $creates ? {
      /^\//   => $creates,
      default => "${path}/${creates}",
    }
    exec { "touch ${creates_path}":
      user        => $user,
      group       => $group,
      path        => ['/bin','/usr/bin'],
      subscribe   => Exec["${path}/${command}"],
      refreshonly => true,
    }
  }

  # Runs 'make' unless target file specified
  # is newer than Makefile
  exec { "${path}/${command}":
    command => $command,
    cwd     => $path,
    user    => $user,
    group   => $group,
    path    => ['/bin','/usr/bin'],
    onlyif  => $check,
  }

}
