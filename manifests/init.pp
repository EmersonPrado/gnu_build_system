# Class: gnu_build_system
# ===========================
#
# Installs required packages to manage the GNU Build System.
#
# Parameters
# ----------
#
# gcc_manage (boolean)
#   Specifies whether to install compiler packages
#   Default => true
#
# gcc_packages (string or hash)
#   Specifies which compiler packages to install
#   Default => undef (uses packages determined in puppetlabs-gcc module)
#
# make_manage (boolean)
#   Specifies whether to install make
#   Default => true
#
# make_package (string)
#   Specifies which compiler package to install
#   Default => undef (uses package determined in puppet-make module)
#
# Examples
# --------
#
# @example - Installs default OS compiler and make
#   include gnu_build_system
#
# @example - Installs 'make-guile' instead of 'make' and doesn't mess with gcc
#    class { 'gnu_build_system':
#      gcc_manage   => false,
#      make_package => 'make-guile',
#    }
#
# Authors
# -------
#
# Emerson Prado <emerson.prado.eng@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class gnu_build_system (
  $gcc_manage   = true,
  $gcc_packages = undef,
  $make_manage  = true,
  $make_package = undef,
){

  if $gcc_manage {
    class { 'gcc':
      gcc_packages => $gcc_packages,
    }
  }

  if $make_manage {
    class { 'make':
      package_name => $make_package,
    }
  }

}
