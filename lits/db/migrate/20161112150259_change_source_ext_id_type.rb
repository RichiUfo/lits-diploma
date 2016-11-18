class ChangeSourceExtIdType < ActiveRecord::Migration[5.0]
  def change
    change_column :sources, :ext_id, :bigint
    add_index :sources, :ext_id
  end
end
