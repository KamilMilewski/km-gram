# :nodoc:
class Post < ApplicationRecord
  acts_as_votable
  validates :user_id, presence: true
  validates :image, presence: true
  # 640x - images are resizing ewery image to 640px wide. But there is no limit
  # to image height.
  has_attached_file :image, styles: { medium: '640x', thumb: '100x' },
                            default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  scope :of_followed_users, -> (following_users) { where user_id: following_users }
end
