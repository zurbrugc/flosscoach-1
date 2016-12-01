FactoryGirl.define do
  factory :user do
    name     "User Test"
    email    "teste@teste.com"
    password "teste123"
    contributed_projects "Flosscoach"
    operational_systems "Ubuntu, Windows"
    programming_languages "Python"
    id "15"
  end
end