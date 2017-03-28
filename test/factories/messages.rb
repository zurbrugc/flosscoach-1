FactoryGirl.define do
  factory :message do
    user
    topic
    sequence(:content)  { |n| "Content of a message in forum #{n}"}
  end
end
