class Dish < ApplicationRecord
  after_create :init_zindex

  belongs_to :category

  mount_uploader :picurl, DishUploader
  mount_base64_uploader :picurl, DishUploader

  protected

  def init_zindex
    update_attributes(zindex: id + 1)
  end
end
