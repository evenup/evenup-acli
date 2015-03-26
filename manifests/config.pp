# == Class: acli::config
#
# This class configures acli.  It should not be called directly.
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class acli::config (
  $version           = $::acli::version,
  $bamboo_server     = $::acli::bamboo_server,
  $confluence_server = $::acli::confluence_server,
  $crucible_server   = $::acli::crucible_server,
  $fisheye_server    = $::acli::fisheye_server,
  $jira_server       = $::acli::jira_server,
  $stash_server      = $::acli::stash_server,
){

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { '/opt/acli/atlassian.sh':
    ensure  => 'file',
    mode    => '0550',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/atlassian.sh.erb"),
  }

}
