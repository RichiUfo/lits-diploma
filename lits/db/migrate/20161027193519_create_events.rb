class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.datetime :date
      t.references :city, foreign_key: true
      t.text :name
      t.text :picture
      t.text :description
      t.text :address
      t.string :coordinates
      t.float :price
      t.references :organizer, foreign_key: true
      t.text :reg_ref
      t.references :category, foreign_key: true
      t.string :ext_id
      t.references :source, foreign_key: true
      t.references :format, foreign_key: true

      t.timestamps
    end
  end
end
