redmine_daily_status
====================

## About: 

* a small project team of size 2-5 or may be more, where team lead does send daily status email to product manager or other seniors
* and then it requires to maintain those emails archived in inbox
* this daily status can be useful to compile monthly reports or similar use case
* each one receiving this daily status email needs to save it if found important to him or her
* team using redmine needed a solution here not to consume inbox of everyone involved
* all material w.r.t. project tracking should be maintained by one tool
* hence we decided to develop this simple plugin for us
* one might find this specific to a particular use case, and it is
* but yes one may find it ready to use and/or fork it to address her additional needs

## Features

* Update Today's Status
* View past days status
* Email send to all project members


## How to Install:

To install the Daily Status, execute the following commands from the plugin directory of your redmine directory:

    git clone https://github.com/gs-lab/redmine_daily_status
    rake redmine:plugins:migrate NAME=redmine_daily_status

After the plugin is installed and the db migration completed, you will
need to restart Redmine for the plugin to be available.

## How to Use:

* Enable the plugin from the settings of the project.

* Assigning permission to users for viewing and updating the status.

* User can only add/update the current date's status.He can only view the past dates project status.

* If user click the "send email to members" check box and then update the status.Email will be send to all the project members with 
the current day status.

## How to UnInstall:

* rake redmine:plugins:migrate NAME=redmine_daily_status VERSION=0
* Remove the redmine_daily_status directory from the plugin directory and then restart redmine.
