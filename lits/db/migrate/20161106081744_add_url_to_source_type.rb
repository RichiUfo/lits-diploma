class AddUrlToSourceType < ActiveRecord::Migration[5.0]
  def change
    add_column :source_types, :url, :string
  end
end
