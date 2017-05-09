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
  $creates = undef,
  $user    = undef,
  $group   = undef,
) {

  $command = join(concat(['make'], $opts, $target), ' ')

  if $creates == undef {
    $check = 'true'
  }
  else {
    $check = "test Makefile -nt ${creates}"
    exec { "touch ${path}/${creates}":
      user        => $user,
      group       => $group,
      path        => ['/bin','/usr/bin'],
      subscribe   => Exec["${path}/${command}"],
      refreshonly => true,
    }
  }

  exec { "${path}/${command}":
    command => $command,
    cwd     => $path,
    user    => $user,
    group   => $group,
    path    => ['/bin','/usr/bin'],
    onlyif  => $check,
  }

}
