class CreateDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :dishes do |t|
      t.string :name, null: false
      t.string :description
      t.string :picture
      t.jsonb :categories
      t.integer :price, null: false
      t.timestamps
    end
  end
end
