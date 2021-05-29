# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :source

  validates :title, :url, presence: true
  validates :uid, presence: true, uniqueness: { scope: :source_id }
end
