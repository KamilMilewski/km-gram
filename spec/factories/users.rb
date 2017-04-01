FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Factory_user_#{n}" }
    sequence(:email) { |n| "factory@user#{n}.com" }
    password 'supersecret'
    sequence(:id) { |n| n }
    sequence(:bio) { |n| "bio #{n}" }
  end
end
