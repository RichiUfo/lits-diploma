class CreateSources < ActiveRecord::Migration[5.0]
  def change
    create_table :sources do |t|
      t.references :source_type, foreign_key: true
      t.text 	   :ref

      t.timestamps
    end
  end
end
