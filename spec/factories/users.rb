FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Factory user #{n}" }
    sequence(:email) { |n| "factory@user#{n}.com" }
    password 'supersecret'
    sequence(:id) { |n| n }
  end
end
