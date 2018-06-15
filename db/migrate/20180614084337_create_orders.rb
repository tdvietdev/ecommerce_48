class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :status, default: 0
      t.datetime :shipped_at
      t.text :address
      t.string :phone
      t.text :comment

      t.timestamps
    end
  end
end
