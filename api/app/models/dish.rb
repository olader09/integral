class Dish < ApplicationRecord
  after_create :init_zindex

  validates :price, presence: true

  mount_uploader :picture, DishUploader
  mount_base64_uploader :picture, DishUploader

end
