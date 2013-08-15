class TestModelWithAttributeDisableConfirmation < ActiveRecord::Base
  self.table_name = "test_model_with_attributes"
  has_secure_password
  has_secure_security_answer confirmation: false

  validates :username,          presence: true, uniqueness: {case_sensitive: false}
  validates :security_question, presence: true
end