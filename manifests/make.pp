# Defined type gnu_build_system::make
#
# Runs 'make' in a given directory
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
  $user    = undef,
  $group   = undef,
) {

  $command = join(concat(['make'], $opts, $target), ' ')

  exec { "${path}/${command}":
    command => $command,
    cwd     => $path,
    user    => $user,
    group   => $group,
    path    => ['/bin','/usr/bin'],
  }

}
