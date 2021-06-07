# frozen_string_literal: true

class AddTwitterFieldsToSourcesAndPosts < ActiveRecord::Migration[6.1]
  def up
    add_column :sources, :post_to_twitter, :boolean, null: false, default: true
    add_column :posts, :posted_to_twitter_at, :datetime
    execute "UPDATE posts SET posted_to_twitter_at = created_at"
    execute "UPDATE sources SET post_to_twitter = 'f' WHERE coverage = 'Industry-Wide' OR active = 'f' OR post_to_discord = 'f'"
  end

  def down
    remove_column :posts, :posted_to_twitter_at
    remove_column :sources, :post_to_twitter
  end
end
