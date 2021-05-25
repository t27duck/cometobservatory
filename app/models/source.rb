# frozen_string_literal: true

class Source < ApplicationRecord
  has_many :pending_posts, dependent: :destroy
  has_many :posts, dependent: :destroy
end
