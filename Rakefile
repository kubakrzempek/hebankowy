$LOAD_PATH << File.expand_path("../", __FILE__)
require "app"

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    Sequel.extension :migration
    db = Hebankowy::App.database
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
  end
end

require "rake/testtask"
Rake::TestTask.new do |t|
  t.test_files = FileList["tests/**/*_test.rb"]
end

task default: :test
