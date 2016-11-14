class DropSocialTypesTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :social_types
  end
end
