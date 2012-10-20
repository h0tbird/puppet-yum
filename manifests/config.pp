# = Class: yum::config
#
#  This class is part of the yum module.
#  You should not be calling this class.
#  The delegated class is Class['yum'].
#
#  Marc Villacorta <marc.villacorta@gmail.com>
#  2012-10-20
#
class yum::config {

    # Collect variables:
    $templates = getvar("::${module_name}::params::templates")
    $configs   = getvar("::${module_name}::params::configs")

    # Install the configuration files:
    file {

        $configs[0]:
            ensure  => present,
            content => template("${templates}/yum.conf.erb"),
            owner   => 'root',
            group   => 'root',
            mode    => '0644';

        $configs[1]:
            ensure  => directory,
            recurse => true,
            purge   => true,
    }

    # Configure the provided repositories:
    if $::yum::repos {
        create_resources(yum::repo, $::yum::repos)
    }

    # To be triggered by Yumrepo:
    exec { 'yum_clean_all':
        user        => 'root',
        group       => 'root',
        refreshonly => true,
        path        => '/usr/bin',
        command     => 'yum clean all',
    }
}
