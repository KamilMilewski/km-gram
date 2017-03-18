require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:notified_by) { create(:user) }
  let!(:post) { create(:post) }
  let!(:notification) do
    create(
      :notification,
      user: user,
      notified_by: notified_by,
      post: post,
      identifier: 1,
      notice_type: 'comment',
      id: 1
    )
  end
  describe 'GET #link_through' do
    it 'returns http success' do
      get :link_through, params: { id: 1 }
      expect(response).to have_http_status(:redirect)
    end
  end
end
