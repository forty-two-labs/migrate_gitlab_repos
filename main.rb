GITLAB_NAMESPACE=''

EXISTING_GITLAB=''

NEW_GITLAB=''
NEW_GITLAB_PRIVATE_TOKEN=''
NEW_GITLAB_NAMESPACE_ID=

PROJECT_NAMES = %w(project-one project-two)

def bundle_existing_repos(project_name)
  Dir.mkdir "existing_repos"
  Dir.chdir "existing_repos"
  system "git clone git@#{EXISTING_GITLAB}:#{GITLAB_NAMESPACE}/#{project_name}.git "
  Dir.chdir "#{project_name}"
  system "git fetch --all"
  system "git pull --all"
  system "git bundle create #{project_name}.bundle --all"
  Dir.chdir ".."
  Dir.chdir ".."
end

def create_new_repos_and_push_bundle(project_name)
  Dir.mkdir "new_repos"
  Dir.chdir "new_repos"

  system "curl -H \"PRIVATE-TOKEN: #{NEW_GITLAB_PRIVATE_TOKEN}\" -H \"Content-Type:application/json\" http://#{NEW_GITLAB}/api/v3/projects -d '{ \"name\": \"#{project_name}\", \"namespace_id\": #{NEW_GITLAB_NAMESPACE_ID}, \"visibility_level\": 10 }'"
  system "git clone git@#{NEW_GITLAB}:#{GITLAB_NAMESPACE}/#{project_name}.git "
  Dir.chdir "#{project_name}"
  system "git pull ../../existing_repos/#{project_name}/#{project_name}.bundle"
  system "git push origin master"
  Dir.chdir ".."
  Dir.chdir ".."
end

def migrate_project(project_name)
  bundle_existing_repos(project_name)
  create_new_repos_and_push_bundle(project_name)
end

PROJECT_NAMES.each do |project_name|
  migrate_project(project_name)
end
