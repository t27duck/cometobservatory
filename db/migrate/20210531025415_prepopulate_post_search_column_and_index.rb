# frozen_string_literal: true

class PrepopulatePostSearchColumnAndIndex < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def up
    Post.in_batches do |group|
      group.update_all("created_at = created_at")
    end

    # https://iamsafts.com/posts/postgres-gin-performance/
    execute "CREATE INDEX CONCURRENTLY index_posts_on_searchable_tsearch ON public.posts USING gin (searchable_tsearch) WITH (gin_pending_list_limit = 128)"
  end

  def down
    remove_index :posts, :searchable_tsearch
  end
end
