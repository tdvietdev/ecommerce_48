class AddGrandTotalToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :grand_total, :integer, default: 0
  end
end
