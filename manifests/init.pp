# = Class: yum
#
#  This module manages YUM and its repositories.
#
#  Marc Villacorta <marc.villacorta@gmail.com>
#  2012-10-20
#
#  Tested platforms:
#    - CentOS 6
#
# == Parameters:
#
#  [*version*]
#    Package version. Must be 'present' or 'latest'.
#
#  [*cachedir*]
#    Directory where yum should store its cache and db files.
#    The default is ‘/var/cache/yum’.
#
#  [*keepcache*]
#    Either ‘1’ or ‘0’. Determines whether or not yum keeps the cache of
#    headers and packages after successful installation.
#    Default is ’1’ (keep files)
#
#  [*debuglevel*]
#    Debug message output level. Practical range is 0-10. Default is ‘2’.
#
#  [*logfile*]
#    Full directory and file name for where yum should write its log file.
#
#  [*exactarch*]
#    Either ‘1’ or ‘0’. Set to ‘1’ to make yum update only update the
#    architectures of packages that you have installed. ie: with this enabled
#    yum will not install an i686 package to update an i386 package.
#    Default is ‘1’.
#
#  [*obsoletes*]
#    This option only has affect during an update. It enables yum’s obsoletes
#    processing logic. Useful when doing distribution level upgrades. See also
#    the yum upgrade command documentation for more details (yum(8)).
#    Default is ‘true’.
#
#  [*gpgcheck*]
#    Either ‘1’ or ‘0’. This tells yum whether or not it should perform a GPG
#    signature check on the packages gotten from this repository.
#
#  [*plugins*]
#    Either ‘0’ or ‘1’. Global switch to enable or disable yum plugins. Default
#    is ‘0’ (plugins disabled). See the PLUGINS section of the yum(8) man for
#    more information on installing yum plugins.
#
#  [*installonly_limit*]
#    Number of packages listed in installonlypkgs to keep installed at the same
#    time. Setting to 0 disables this feature. Default is ’3’. Note that this
#    functionality used to be in the "installonlyn" plugin, where this option
#    was altered via. tokeep. Note that as of version 3.2.24, yum will now look
#    in the yumdb for a installonly attribute on installed packages. If that
#    attribute is "keep", then they will never be removed.
#
#  [*bugtracker_url*]
#    URL where bugs should be filed for yum. Configurable for local versions or
#    distro-specific bugtrackers.
#
#  [*distroverpkg*]
#    The package used by yum to determine the "version" of the distribution.
#    This can be any installed package. Default is ‘redhat-release’. You can
#    see what provides this by using: "yum whatprovides red-hat-release".
#
#  [*repos*]
#    List of repositories in hash format.
#
# == Actions:
#
#  Installs and configures YUM and its repositories.
#
# == Sample Usage:
#
#  include yum
#
class yum (

    $version           = undef,
    $cachedir          = undef,
    $keepcache         = undef,
    $debuglevel        = undef,
    $logfile           = undef,
    $exactarch         = undef,
    $obsoletes         = undef,
    $gpgcheck          = undef,
    $plugins           = undef,
    $installonly_limit = undef,
    $bugtracker_url    = undef,
    $distroverpkg      = undef,
    $repos             = undef,

) {

    # Validate parameters:
    validate_re($version, '^present$|^latest$')
    validate_re($keepcache, '^0$|^1$')

    # Register this module:
    if defined(Class['motd']) { motd::register { $module_name: } }

    # Set the requirements:
    anchor { "::${module_name}::begin":   } ->
    class  { "::${module_name}::params":  } ->
    class  { "::${module_name}::install": } ->
    class  { "::${module_name}::config":  } ->
    anchor { "::${module_name}::end":     }
}
