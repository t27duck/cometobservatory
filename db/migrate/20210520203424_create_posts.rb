class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :source, null: false, foreign_key: true
      t.string :title, null: false
      t.string :author
      t.text :summary
      t.string :url, null: false
      t.string :uid, null: false
      t.datetime :published_at

      t.timestamps
    end

    add_index :posts, :uid, unique: true
  end
end
