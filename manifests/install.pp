# == Class: acli::install
#
# This class installs acli.  It should not be called directly.
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
#
# === Copyright
#
# Copyright 2014 EvenUp.
#
class acli::install {

  $filename = "atlassian-cli-${acli::version}-distribution.zip"

  exec { 'fetch_acli':
    command   => "/usr/bin/curl -o ${filename} ${acli::source}/${filename}",
    cwd       => '/tmp',
    creates   => "/tmp/${filename}",
    path      => '/usr/bin/:/bin',
    logoutput => on_failure,
    unless    => "/usr/bin/test -d /opt/atlassian-cli-${acli::version}",
  }

  exec { 'extract_acli':
    command   => "/usr/bin/unzip /tmp/${filename} -d /opt/atlassian-cli-${acli::version}",
    cwd       => '/opt',
    creates   => "/opt/atlassian-cli-${acli::version}",
    path      => '/bin/:/usr/bin/',
    require   => Exec['fetch_acli'],
    logoutput => on_failure,
  }

  file { '/opt/acli':
    ensure  => 'link',
    target  => "/opt/atlassian-cli-${acli::version}",
    require => Exec['extract_acli'],
  }

}
