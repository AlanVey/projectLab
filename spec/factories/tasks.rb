# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name "MyString"
    description "MyText"
    user_id 1
    project_id 1
    difficulty 1
    priority 1
  end
end
