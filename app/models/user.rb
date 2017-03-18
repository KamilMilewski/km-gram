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

  has_attached_file :avatar, styles: { medium: '150x150', thumb: '70x70' },
                             default_url: '/images/:style/default_avatar.png'
  validates_attachment :avatar, content_type: { content_type: ['image/jpeg',
                                                               'image/gif',
                                                               'image/png',
                                                               'image/jpg'] }
end
