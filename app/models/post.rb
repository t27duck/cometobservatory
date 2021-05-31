# frozen_string_literal: true

class Post < ApplicationRecord
  include PgSearch::Model

  belongs_to :source

  validates :title, :url, presence: true
  validates :uid, presence: true, uniqueness: { scope: :source_id }

  pg_search_scope :fulltext_search,
                  against: { title: "A" },
                  using: {
                    tsearch: {
                      dictionary: "english", tsvector_column: "searchable_tsearch"
                    }
                  },
                  order_within_rank: "posts.created_at DESC"
end
