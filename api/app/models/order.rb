class Order < ApplicationRecord
  belongs_to :user
  has_many :orders_dishes
  has_many :dishes, through: :orders_dishes

  def order_dishes
    orders_dishes
  end
end
