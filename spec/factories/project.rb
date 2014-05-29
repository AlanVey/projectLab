FactoryGirl.define do
  factory :project do
    sequence(:name) {|i| "Project#{i}" }
    description "Test description for a project"
    association :user
  end
end