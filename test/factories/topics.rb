FactoryGirl.define do
  factory :topic do
    sequence(:title)  { |n| "Title of a Topic #{n}"}
    locked false
    forum
    user
  end
end
