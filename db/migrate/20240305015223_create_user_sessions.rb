class CreateUserSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token_digest
      t.datetime :token_expiration
      t.string :refresh_token_digest
      t.datetime :refresh_token_expiration
      t.string :device

      t.timestamps
    end
  end
end
