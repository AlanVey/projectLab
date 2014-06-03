# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :milestone do
    due_date "2014-06-03"
    completion_date "2014-06-03"
    name "MyString"
    status "MyString"
  end
end
