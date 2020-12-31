class Spot < ApplicationRecord
  belongs_to :photo

  geocoded_by :address
  after_validation :geocode
end
