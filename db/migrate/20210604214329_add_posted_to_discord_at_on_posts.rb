# frozen_string_literal: true

class AddPostedToDiscordAtOnPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :posted_to_discord_at, :datetime
  end
end
