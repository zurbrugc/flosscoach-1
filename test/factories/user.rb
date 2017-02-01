FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "User #{n}"}
    birth "04/11/1995"
    sequence(:email)  { |n| "email#{n}@gmail.com"}
    sequence(:username)  {|n| "username#{n}"}
  end
end
