class TestModelWithAlternativeSyntax < ActiveRecord::Base
  self.table_name = "test_model_with_attributes"

  has_secure :username
  has_secure :security_answer, validations: false
end
