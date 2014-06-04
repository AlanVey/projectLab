# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :milestone do
    due_date Date.today
    completion_date "2014-06-03"
    name "MyString"
    status "Created"
  end
end
