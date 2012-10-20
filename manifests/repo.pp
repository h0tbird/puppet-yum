# = Define: yum::repo
#
#  This defined type is part of the yum module.
#
#  Marc Villacorta <marc.villacorta@gmail.com>
#  2012-10-20
#
# == Parameters:
#
#  [*descr*]
#    A human-readable description of the repository. This corresponds to the
#    name parameter in yum.conf(5). Set this to absent to remove it from the
#    file completely. Valid values are absent. Values can match /.*/.
#
#  [*baseurl*]
#    Must be a URL to the directory where the yum repository’s ‘repodata’
#    directory lives. Can be an http://, ftp:// or file:// URL.
#
#  [*mirrorlist*]
#   The URL that holds the list of mirrors for this repository. Set this to
#   absent to remove it from the file completely. Valid values are absent.
#   Values can match /.*/.
#
#  [*enabled*]
#   Whether this repository is enabled, as represented by a 0 or 1. Set this to
#   absent to remove it from the file completely. Valid values are absent.
#   Values can match /(0|1)/.
#
#  [*gpgcheck*]
#   Whether to check the GPG signature on packages installed from this
#   repository, as represented by a 0 or 1. Set this to absent to remove it
#   from the file completely. Valid values are absent.
#   Values can match /(0|1)/.
#
#  [*gpgkey*]
#    The URL for the GPG key with which packages from this repository are
#    signed. Set this to absent to remove it from the file completely. Valid
#    values are absent. Values can match /.*/.
#
#  [*failovermethod*]
#    The failover methode for this repository; should be either roundrobin or
#    priority. Set this to absent to remove it from the file completely. Valid
#    values are absent. Values can match /roundrobin|priority/.
#
#  [*priority*]
#    Priority of this repository from 1-99. Requires that the priorities plugin
#    is installed and enabled. Set this to absent to remove it from the file
#    completely. Valid values are absent. Values can match /[1-9][0-9]?/.
#
#  [*exclude*]
#    List of shell globs. Matching packages will never be considered in updates
#    or installs for this repo. Set this to absent to remove it from the file
#    completely. Valid values are absent. Values can match /.*/.
#
#  [*includepkgs*]
#    List of shell globs. If this is set, only packages matching one of the
#    globs will be considered for update or install from this repo. Set this to
#    absent to remove it from the file completely. Valid values are absent.
#    Values can match /.*/.
#
# == Actions:
#
#  Creates the client-side description of a yum repository.
#
# == Sample Usage:
#
#  create_resources(yum::repo, $::yum::repos)
#
define yum::repo (

    $descr          = undef,
    $baseurl        = undef,
    $mirrorlist     = undef,
    $enabled        = undef,
    $gpgcheck       = undef,
    $gpgkey         = undef,
    $failovermethod = undef,
    $priority       = undef,
    $exclude        = undef,
    $includepkgs    = undef,

){
    yumrepo { $title:
        descr          => $name,
        baseurl        => $baseurl,
        mirrorlist     => $mirrorlist,
        enabled        => $enabled,
        gpgcheck       => $gpgcheck,
        gpgkey         => $gpgkey,
        failovermethod => $failovermethod,
        priority       => $priority,
        exclude        => $exclude,
        includepkgs    => $includepkgs,
        notify         => Exec['yum_clean_all']
    }

    file { "/etc/yum.repos.d/${title}.repo":
        ensure  => present,
        replace => false,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        before  => Yumrepo[$title],
    }
}
