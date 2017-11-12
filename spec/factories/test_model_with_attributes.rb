FactoryBot.define do
  factory :test_model_with_attribute do
    username 'username'
    password 'password'
    password_confirmation 'password'
    security_question 'question'
    security_answer 'answer'
    security_answer_confirmation 'answer'
  end

  factory :test_model_with_attribute_no_validation do
    username 'username_no_validation'
    password 'password'
    password_confirmation 'password'
    security_question 'question'
    security_answer 'answer'
  end

  factory :test_model_with_attribute_protect_setter_for_digest do
    username 'username_protect'
    password 'password'
    password_confirmation 'password'
    security_question 'question'
    security_answer 'answer'
    security_answer_confirmation 'answer'
  end

  factory :test_model_with_attribute_with_case_sensitive do
    username 'username_protect'
    password 'password'
    password_confirmation 'password'
    security_question 'question'
    security_answer 'answer'
    security_answer_confirmation 'answer'
  end

  factory :test_model_with_attribute_disable_confirmation do
    username 'username_protect'
    password 'password'
    password_confirmation 'password'
    security_question 'question'
    security_answer 'answer'
  end
end
