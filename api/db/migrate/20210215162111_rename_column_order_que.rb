class RenameColumnOrderQue < ActiveRecord::Migration[5.1]
  def change
    rename_column :orders, :order_que, :order_queue
  end
end
