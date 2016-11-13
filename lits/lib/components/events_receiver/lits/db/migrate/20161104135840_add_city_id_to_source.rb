class AddCityIdToSource < ActiveRecord::Migration[5.0]
  def change
    add_column :sources, :city_id, :integer
  end
end
