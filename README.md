# migrate_gitlab_repos

ruby script to migrate git repos from one gitlab server and another gitlab server


## Notes

the script will create two folders in the current directories:

* existing_repos
* new_repos

the script is basically doing:

* create existing_repos directory
* git clone the project repo
* generate a git bundle
* create new_repos directory
* create new project repo on new git server
* git clone the empty new project repo from new git server
* pull the bundle from existing_repos generated
* git push the changes to new git server


## Parameters

set the following values in the main.rb script:

* GITLAB_NAMESPACE - the namespace of the repo
* EXISTING_GITLAB - domain name or ip address of current gitlab server
* NEW_GITLAB - domain name or ip address of new gitlab server
* NEW_GITLAB_PRIVATE_TOKEN -  private token of new gitlab server (you can find it inside new gitlab web UI, Profile settings > Account)
* NEW_GITLAB_NAMESPACE_ID - you have to create the namespace on the new server manually first (could be done via HTTP API, but I didn't that)
* PROJECT_NAMES - array of project names that you want to migrate
