# frozen_string_literal: true

class AddSearchableTsearchToPosts < ActiveRecord::Migration[6.1]
  def up
    add_column :posts, :searchable_tsearch, :tsvector

    # Add function
    execute File.read(Rails.root.join("db", "functions", "posts_search_trigger.sql"))

    # Set function to trigger
    execute <<~SQL
      CREATE TRIGGER posts_search_trigger BEFORE INSERT OR UPDATE
      ON posts FOR EACH ROW EXECUTE FUNCTION posts_search_trigger();
    SQL
  end

  def down
    execute "DROP FUNCTION posts_search_trigger CASCADE"
    remove_column :posts, :searchable_tsearch
  end
end
