class RemoveUnneededFieldsFromUser < ActiveRecord::Migration[5.0]
  def change
    # remove_index :users, :confirmation_token
    # remove_index :users, :reset_password_token
    # remove_index :users, :social_type_id

    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :remember_created_at
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email
    remove_column :users, :social_type_id
    remove_column :users, :social_id
  end
end
