# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_user do
    email "test@gmail.com"
    association :project
    user_id 1
  end
end
