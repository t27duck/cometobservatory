class CreateSources < ActiveRecord::Migration[6.1]
  def change
    create_table :sources do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :image_filename
      t.string :source_class, null: false

      t.timestamps
    end
  end
end
