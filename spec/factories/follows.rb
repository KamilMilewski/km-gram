FactoryGirl.define do
  factory :follow do
    following { create(:user) }
    follower { create(:user) }
  end
end
