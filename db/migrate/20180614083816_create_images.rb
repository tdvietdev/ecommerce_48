class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :image
      t.references :product, foreign_key: true
      t.boolean :avatar, default: false

      t.timestamps
    end
  end
end
