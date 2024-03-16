class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.string :resource, null: false
      t.timestamps
    end
  end
end
