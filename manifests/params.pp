# = Class: yum::params
#
#  This class is part of the yum module.
#  You should not be calling this class.
#  The delegated class is Class['yum'].
#
#  Marc Villacorta <marc.villacorta@gmail.com>
#  20112-10-20
#
class yum::params {

    # Set location for files and templates:
    $files     = "puppet:///modules/${module_name}"
    $templates = "${module_name}"

    # Set OS specifics:
    case $osfamily {

        'RedHat': {
            $packages = ['yum']
            $configs  = ['/etc/yum.conf','/etc/yum.repos.d']
        }

        default: { fail("${module_name}::params ${osfamily} family is not supported yet.") }
    }
}
