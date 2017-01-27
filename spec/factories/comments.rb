FactoryGirl.define do
  factory :comment do
    sequence(:content) { |n| "comment #{n}" }
    user nil
    post nil
  end
end
