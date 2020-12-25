class Category < ApplicationRecord
  mount_uploader :category_image, ImageUploader

  has_many :photo_categories
  has_many :photos, through: :photo_categories
end
