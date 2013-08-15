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
    task :create do |t|
      begin
        HasSecureAttribute::DbHelper.new.connect_to_server
        ActiveRecord::Migration.create_database 'has_secure_attribute_test'
      rescue Exception => ex
        nil
      end
    end

    task :migrate do |t|
      CreateTestModelWithAttributes.new.up
    end

    task :rollback do |t|
      CreateTestModelWithAttributes.new.down
    end

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

task :default => ["has_secure_attribute:db:drop", "has_secure_attribute:db:create", "has_secure_attribute:db:migrate", :spec]


