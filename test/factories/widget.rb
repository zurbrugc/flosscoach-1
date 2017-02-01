FactoryGirl.define do
  factory :widget do
    sequence(:title)  { |n| "Title widget #{n}"}
    tab "about"
    pos_x 0
    pos_y 0
    width 0
    height 0
    content "Random content."
    project
  end
end
