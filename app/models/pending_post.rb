# frozen_string_literal: true

class PendingPost < ApplicationRecord
  belongs_to :source

  def self.create_from_feedjira(source, entry)
    identifier = entry.entry_id || entry.url
    return if Post.exists?(uid: identifier)
    return if entry.url.blank?

    title = entry.title.presence || entry.url
    PendingPost.create!(
      source: source,
      post_attributes: {
        title: title,
        url: entry.url,
        author: entry.author,
        published_at: entry.published,
        uid: identifier,
        summary: entry.content.presence || entry.summary.presence
      }
    )
  end

  def create_post!
    if Post.exists?(uid: post_attributes["identifier"])
      destroy!
    else
      transaction do
        Post.create!(
          source: source,
          title: post_attributes["title"],
          url: post_attributes["url"],
          author: post_attributes["author"],
          published_at: post_attributes["published"],
          uid: post_attributes["identifier"],
          summary: post_attributes["summary"]
        )
        destroy!
      end
    end
  end
end
