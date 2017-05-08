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
) {

  exec { "${path}/configure":
    command => 'configure',
    cwd     => $path,
    path    => [$path],
  }

}
