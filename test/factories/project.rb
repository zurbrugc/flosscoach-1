FactoryGirl.define do
  factory :project do
    sequence(:name)  { |n| "Project #{n}"}
    description "A simple project description."
    forum
  end
end
