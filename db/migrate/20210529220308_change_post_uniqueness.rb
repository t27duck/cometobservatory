# frozen_string_literal: true

class ChangePostUniqueness < ActiveRecord::Migration[6.1]
  def change
    remove_index :posts, :uid, unique: true
    add_index :posts, [:uid, :source_id], unique: true
  end
end
