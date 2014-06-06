# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    comment "MyText"
    association :task
    creator_email "MyString"
  end
end
