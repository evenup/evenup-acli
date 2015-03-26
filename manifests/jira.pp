# == Define: acli::task
#
# This define generates cron entries to create scheduled jira issues
#
#
# === Parameters
#
# [*project*]
#   String. Name of Jira project
#   Required
#
# [*summary*]
#   String.  Summary of the issue
#   Required
#
# [*assignee*]
#   String.  Username to assign the issue to
#
# [*description*]
#   String.  Description field of the issue
#
# [*labels*]
#   String.  Labels to apply to the issue (space seperated)
#
# [*parent*]
#   String.  Parent issue
#
# [*type*]
#   String.  Issue type
#
# [*monthday*]
#   Cron value of the monthday field
#
# [*month*]
#   Cron value of the month field
#
# [*hour*]
#   Cron value of the hour field
#
# [*minute*]
#   Cron value of the minute field
#
# [*weekday*]
#   Cron value of the weekday field
#
#
# === Examples
#
# acli::jira { 'test_backups':
#   project     => 'admin',
#   summary     => 'Quarterly production backups test',
#   description => 'Production database backups need to be restored and verified with the verification scripts',
#   month       => '1,4,7,10'
# }
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
define acli::jira (
  $project,
  $summary,
  $assignee     = undef,
  $description  = undef,
  $labels       = undef,
  $parent       = undef,
  $type         = 'task',
  $monthday     = 1,
  $month        = 1,
  $hour         = 0,
  $minute       = 1,
  $weekday      = '*',
  $ensure       = 'present',
) {

  if $labels {
    $_labels = "--labels '${labels}'"
  } else {
    $_labels = undef
  }

  if $assignee {
    $_assignee = "--assignee '${assignee}'"
  } else {
    $_assignee = undef
  }

  if $description {
    $_description = "--description '${description}'"
  } else {
    $_description = undef
  }

  if $parent {
    $_parent = "--parent '${parent}'"
  } else {
    $_parent = undef
  }

  $_type = "--type '${type}'"

  $options = chomp(join(delete_undef_values([$_type, $_labels, $_assignee, $_description, $_parent]), ' '))

  cron { "jira_${name}":
    ensure   => $ensure,
    command  => "/opt/acli/atlassian.sh jira --action createIssue --project '${project}' --summary '${summary}' ${options}",
    hour     => $hour,
    minute   => $minute,
    month    => $month,
    monthday => $monthday,
    weekday  => $weekday,

  }

}
