class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :city,      foreign_key: true
      t.references :organizer, foreign_key: true
      t.references :category,  foreign_key: true
      t.references :source,    foreign_key: true
      t.references :format,    foreign_key: true
      t.datetime   :date
      t.float      :price
      t.string     :coordinates
      t.string     :ext_id
      t.text       :name
      t.text       :picture
      t.text       :description
      t.text       :address
      t.text       :reg_ref

      t.timestamps
    end
  end
end
