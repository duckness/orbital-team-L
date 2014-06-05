FactoryGirl.define do
  factory :user do
    name     "Example User"
    email    "user@example.com"
    password "foobarfoo"
    password_confirmation "foobarfoo"
  end
end