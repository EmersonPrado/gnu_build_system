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
) {

  $command = join(concat(['configure'], $opts, $vars), ' ')

  exec { "${path}/configure":
    command => $command,
    cwd     => $path,
    path    => [$path],
  }

}
