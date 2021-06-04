# frozen_string_literal: true

class PresetPostedToDiscordAtOnExistingPosts < ActiveRecord::Migration[6.1]
  def up
    execute "UPDATE posts SET posted_to_discord_at = created_at"
  end

  def down
    Post.update_all(posted_to_discord_at: nil)
  end
end
