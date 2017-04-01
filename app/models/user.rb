class User < ApplicationRecord
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { minimum: 4, maximum: 25 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id,
                                   class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id,
                                    class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  has_attached_file :avatar, styles: { medium: '150x150', thumb: '70x70' },
                             default_url: '/images/:style/default_avatar.png'
  validates_attachment :avatar, content_type: { content_type: ['image/jpeg',
                                                               'image/gif',
                                                               'image/png',
                                                               'image/jpg'] }

  def follow(following)
    following_relationships.create(following_id: following.id, follower_id: id)
  end

  def unfollow(following)
    following_relationships.find_by(following_id: following.id, follower_id: id).destroy
  end
end
