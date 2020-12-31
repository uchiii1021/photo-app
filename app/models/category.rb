class Category < ApplicationRecord
  mount_uploader :category_image, ImageUploader

  validates :category_name, presence: true, length: { maximum: 10 }
  validates :category_image, presence: true

  has_many :photo_categories
  has_many :photos, through: :photo_categories
end
