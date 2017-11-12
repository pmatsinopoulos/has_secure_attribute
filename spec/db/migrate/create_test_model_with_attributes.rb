class CreateTestModelWithAttributes < ActiveRecord::Migration[5.1]
  def up
    HasSecureAttribute::DbHelper.new.connect_to_database
    return if ActiveRecord::Base.connection.table_exists? :test_model_with_attributes
    create_table :test_model_with_attributes do |t|
      t.string :username,               :null => false
      t.string :password_digest,        :null => false
      t.string :security_question,      :null => false
      t.string :security_answer_digest, :null => false

      t.timestamps
    end

    add_index :test_model_with_attributes, [:username], :unique => true, :name => 'test_model_with_attributes_username_uidx'
  end

  def down
    HasSecureAttribute::DbHelper.new.connect_to_database
    return unless ActiveRecord::Base.connection.table_exists? :test_model_with_attributes
    drop_table :test_model_with_attributes
  end


end
