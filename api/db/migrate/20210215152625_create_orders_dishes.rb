class CreateOrdersDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :orders_dishes do |t|
      t.belongs_to :order
      t.belongs_to :dish
      t.integer :quantity, default: 1
    end
  end
end
