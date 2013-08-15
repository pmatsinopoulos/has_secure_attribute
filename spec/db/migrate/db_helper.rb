module HasSecureAttribute
  class DbHelper
    def connect_to_database
      filename = File.expand_path("../../../config/database.yml", __FILE__)
      database_settings = YAML.load_file(filename)
      ActiveRecord::Base.establish_connection database_settings['test']
    end

    def connect_to_server
      filename = File.expand_path("../../../config/database.yml", __FILE__)
      database_settings = YAML.load_file(filename)
      ActiveRecord::Base.establish_connection database_settings['test'].delete_if{|k,v| 'database' == k}
    end
  end
end