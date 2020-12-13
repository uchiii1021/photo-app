class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :image, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
end
