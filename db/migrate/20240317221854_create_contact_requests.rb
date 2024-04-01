class CreateContactRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_requests do |t|
      t.string :name, null: false 
      t.string :cellphone
      t.string :email
      t.text :message
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
