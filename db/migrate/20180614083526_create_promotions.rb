class CreatePromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.references :product, foreign_key: true
      t.integer :percent
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
