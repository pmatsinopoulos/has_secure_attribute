FactoryGirl.define do
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
end