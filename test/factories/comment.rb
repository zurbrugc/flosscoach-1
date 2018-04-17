FactoryBot.define do
  factory :comment do
    content "A simple content of a comment."
    user
    widget
  end
end
