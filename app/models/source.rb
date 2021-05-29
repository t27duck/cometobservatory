# frozen_string_literal: true

class Source < ApplicationRecord
  COVERAGES = ["Nintendo", "Industry-Wide"].freeze
  SOURCE_CLASSES = ["RssFeed"].freeze

  has_many :pending_posts, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :name, :url, presence: true
  validates :source_class, presence: true, inclusion: { in: SOURCE_CLASSES }
  validates :coverage, presence: true, inclusion: { in: COVERAGES }

  def create_pending_posts
    case source_class
    when "RssFeed"
      RssFeed.new(self).create_pending_posts
    else
      raise "Unknown source_class '#{source_class}'"
    end
  end
end
