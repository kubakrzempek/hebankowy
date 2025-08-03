# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
# require "capistrano/rvm"
require "capistrano/rbenv"
# require "capistrano/chruby"
# require "capistrano/bundler"
# require "capistrano/rails/assets"
# require "capistrano/rails/migrations"
# require "capistrano/passenger"

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

desc "Check that we can access everything"
task :check_write_permissions do
  on roles(:all) do |host|
    if test("[ -w #{fetch(:deploy_to)} ]")
      info "#{fetch(:deploy_to)} is writable on #{host}"
    else
      error "#{fetch(:deploy_to)} is not writable on #{host}"
    end
  end
end

namespace :deploy do
  namespace :bundle do
    task :install do
      on roles(:app) do
        within release_path do
          execute :bundle, :install
        end
      end
    end
  end

  namespace :assets do
    task :precompile do
      on roles(:app) do
        within release_path do
          # disabled for time being...
          # execute :npm, :i
          # execute :jspm, :update
          # execute :gulp, :export
        end
      end
    end
  end

  namespace :db do
    task :migrate do
      on roles(:app) do
        within release_path do
          execute :rake, "db:migrate"
        end
      end
    end
  end

  task :restart do
    on roles(:app) do
      within release_path do
        FileUtils.touch "tmp/restart.txt"
      end
    end
  end
end

before "deploy:log_revision", "deploy:bundle:install"
after "deploy:bundle:install", "deploy:assets:precompile"
after "deploy:assets:precompile", "deploy:db:migrate"
after "deploy:db:migrate", "deploy:restart"
