class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { minimum: 4, maximum: 25 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
