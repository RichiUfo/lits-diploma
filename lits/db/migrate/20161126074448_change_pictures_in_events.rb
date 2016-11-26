class ChangePicturesInEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :big_picture, :string, limit: 512
    change_column :events, :picture, :string, limit: 512
  end
end
