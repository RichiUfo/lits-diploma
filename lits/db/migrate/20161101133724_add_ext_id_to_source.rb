class AddExtIdToSource < ActiveRecord::Migration[5.0]
  def change
    add_column :sources, :ext_id, :integer, :limit => 8
  end
end
