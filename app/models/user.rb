class User < ApplicationRecord
  attr_accessor :current_password

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }

  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_photos, through: :likes, source: :photo
  def already_liked?(photo)
    self.likes.exists?(photo_id: photo.id)
  end
end
