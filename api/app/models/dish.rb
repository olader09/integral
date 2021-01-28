class Dish < ApplicationRecord
  validates :price, presence: true

  mount_uploader :picture, DishUploader
  mount_base64_uploader :picture, DishUploader

end
