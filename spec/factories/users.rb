FactoryGirl.define do
  factory :user do
    username 'username'
    password 'password'
    password_confirmation 'password'
    security_answer 'answer'
    security_answer_confirmation 'answer'
  end
end