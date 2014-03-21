FactoryGirl.define do
  factory :user do
    email "test@example.com"
    password 'password'
    role "admin"
  end
end
