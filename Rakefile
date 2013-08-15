require 'rubygems'
require 'rspec/core/rake_task'
require 'active_record'
require File.expand_path('../spec/db/migrate/db_helper', __FILE__)
require File.expand_path('../spec/db/migrate/create_test_model_with_attributes', __FILE__)

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color]
end

namespace "has_secure_attribute" do
  namespace "db" do
    desc "Create the database that is needed for testing (database name: has_secure_attribute_test)"
    task :create do |t|
      begin
        HasSecureAttribute::DbHelper.new.connect_to_server
        ActiveRecord::Migration.create_database 'has_secure_attribute_test'
      rescue Exception => ex
        nil
      end
    end

    desc "Migrate in order to be able to run the tests"
    task :migrate do |t|
      CreateTestModelWithAttributes.new.up
    end

    desc "Rollback migrations that are there for the tests to run successfully"
    task :rollback do |t|
      CreateTestModelWithAttributes.new.down
    end

    desc "Drop database that is needed to run tests"
    task :drop do |t|
      begin
        HasSecureAttribute::DbHelper.new.connect_to_database
        ActiveRecord::Migration.drop_database 'has_secure_attribute_test'
      rescue Exception => ex
        nil
      end
    end
  end
end

desc "Will create the database necessary to run all the tests and then run all the tests"
task :default => ["has_secure_attribute:db:drop", "has_secure_attribute:db:create", "has_secure_attribute:db:migrate", :spec]


