class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :image, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :liked_users, through: :likes, source: :user, dependent: :destroy
  has_many :photo_categories
  has_many :categories, through: :photo_categories, dependent: :destroy
end
