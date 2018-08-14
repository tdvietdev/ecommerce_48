class CreateBanners < ActiveRecord::Migration[5.2]
  def change
    create_table :banners do |t|
      t.text :title
      t.string :picture
      t.text :link
      t.boolean :active

      t.timestamps
    end
  end
end
