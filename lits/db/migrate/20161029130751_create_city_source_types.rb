class CreateCitySourceTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :city_source_types do |t|
      t.references :city, foreign_key: true
      t.references :source_type, foreign_key: true
      t.integer :ext_id
      t.string :ext_name

      t.timestamps
    end
  end
end
