require 'active_record'

require File.expand_path("../db/migrate/db_helper", __FILE__)
HasSecureAttribute::DbHelper.new.connect_to_database

require File.expand_path("../../lib/active_model/secure_attribute/has_secure_attribute", __FILE__)
require File.expand_path("../models/test_model_with_attribute", __FILE__)
require File.expand_path("../models/test_model_with_attribute_no_validation", __FILE__)
require File.expand_path("../models/test_model_with_attribute_protect_setter_for_digest", __FILE__)
require File.expand_path("../models/test_model_with_attribute_with_case_sensitive", __FILE__)
require File.expand_path("../models/test_model_with_attribute_disable_confirmation", __FILE__)
require File.expand_path("../models/test_model_with_alternative_syntax", __FILE__)

require 'factory_bot'
FactoryBot.find_definitions
require 'database_cleaner'

RSpec.configure do |config|

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner[:active_record].start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
