require 'rails_helper'
require 'support/controller_macros'

RSpec.describe RelationshipsController, type: :controller do
  login_user

  describe "GET #follow_user" do
    let!(:user) { create(:user) }

    it "returns http success" do
      get :follow_user, params: { user_name: user.name }, xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #unfollow_user" do
    let!(:user) { create(:user) }
    let!(:follow) { create(:follow, following: user, follower: @user) }

    it "returns http success" do
      get :unfollow_user, params: { user_name: user.name }, xhr: true
      expect(response).to have_http_status(:success)
    end
  end

end
