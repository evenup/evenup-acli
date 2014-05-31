# == Class: acli::config
#
# This class configures acli.  It should not be called directly.
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
class acli::config {

  file { '/opt/acli/atlassian.sh':
    ensure  => 'file',
    mode    => '0550',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/atlassian.sh.erb"),
  }

}
