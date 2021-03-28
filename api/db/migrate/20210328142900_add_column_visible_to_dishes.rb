class AddColumnVisibleToDishes < ActiveRecord::Migration[5.1]
  def change
    add_column :dishes, :visible, :boolean, default: true
  end
end
