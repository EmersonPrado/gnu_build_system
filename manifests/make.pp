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
) {

  exec { "${path}/make":
    command => 'make',
    cwd     => $path,
    path    => ['/bin','/usr/bin'],
  }

}
