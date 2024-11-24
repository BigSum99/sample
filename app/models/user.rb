class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_one_attached :profile_image

  validates :username, presence: true, length: {maximum: 20}
end
