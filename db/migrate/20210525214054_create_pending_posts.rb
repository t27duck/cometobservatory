class CreatePendingPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :pending_posts do |t|
      t.references :source, null: false, foreign_key: true
      t.jsonb :post_attributes, null: false, default: {}

      t.timestamps
    end
  end
end
