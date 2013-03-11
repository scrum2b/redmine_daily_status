redmine_daily_status
====================

About: This plugin is used for tracking the daily status update of the project.

How to Install:

To install the Daily Status, execute the following commands from the plugin directory of your redmine directory:

    git clone https://github.com/gs-lab/redmine_daily_status
    rake redmine:plugins:migrate NAME=redmine_daily_status

After the plugin is installed and the db migration completed, you will
need to restart Redmine for the plugin to be available.

How to Use:

1) Enable the plugin from the settings of the project.

2) Assigning permission to users for viewing and updating the status.

3) User can only add/update the current date's status.He can only view the past dates project status.

4) If user click the "send email to members" check box and then update the status.Email will be send to all the project members with 
the current day status.

How to UnInstall:

rake redmine:plugins:migrate NAME=redmine_daily_status VERSION=0
Remove the redmine_daily_status directory from the plugin directory and then restart redmine.