# = Class: yum::install
#
#   This class is part of the yum module.
#   You should not be calling this class.
#   The delegated class is Class['yum'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2012-10-20
#
class yum::install {

    # Collect variables:
    $version  = getvar("::${module_name}::version")
    $packages = getvar("::${module_name}::params::packages")

    # Install the package/s:
    package { $packages: ensure => $version }
}
