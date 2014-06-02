What is it?
===========

A Puppet module that installs the Atlassian CLI tools from Bob Swift and
Appfire (https://bobswift.atlassian.net/wiki/dashboard.action) and defines
to schedule recurring tasks (via cron).  Currently only Jira tasks are
supported.

Please note a license to use the ACLI software is required!  See
https://bobswift.atlassian.net/wiki/display/ACLI/Atlassian+CLI+license for details.

The puppet module is released under the Apache 2.0 licence

Usage:
------

To install:
<pre>
  class { 'acli':
    user        => 'acli',
    password    => 'something secret',
    jira_server => 'https://jira.example.com',
  }
</pre>

To create a quarterly Jira restore test task
<pre>
  acli::jira { 'quarterly_restore_testing':
    project     => 'OPS',
    summary     => 'Quarterly Prouction Restore Test',
    assignee    => 'jlambert',
    description => 'Test restoring production database backups',
    month       => [1,4,7,10],
  }
</pre>


Contribute:
-----------
* Fork it
* Create a topic branch
* Improve/fix (with spec tests)
* Push new topic branch
* Submit a PR
