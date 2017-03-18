class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notified_by, class_name: User
  belongs_to :post

  validates :user_id, :notified_by_id, :post_id, :identifier, :notice_type,
            presence: true

  scope :read, -> { where(read: true).order('created_at DESC') }
  scope :unread, -> { where(read: false).order('created_at DESC') }
end
