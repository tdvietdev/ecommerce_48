class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.string :subject_class

      t.timestamps
    end
  end
end
