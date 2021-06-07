# frozen_string_literal: true

namespace :observatory do
  task fetch: :environment do
    Rake::Task["observatory:fetch_pending"].invoke
    Rake::Task["observatory:process_pending"].invoke
    Rake::Task["discord:post_to_webhook"].invoke
    Rake::Task["observatory:post_to_twitter"].invoke
  end

  task fetch_pending: :environment do
    Source.where(active: true).find_each do |source|
      begin
        source.create_pending_posts
      rescue => e
        Rails.logger.error("#{source.name} - #{e.message}")
      end
    end
  end

  task process_pending: :environment do
    PendingPostProcessor.new.process
  end

  task post_to_twitter: :environment do
    next unless ENV["ROSALINA_TWITTER_CONSUMER_KEY"].present?
    next unless ENV["ROSALINA_TWITTER_CONSUMER_SECRET"].present?
    next unless ENV["ROSALINA_TWITTER_ACCESS_TOKEN"].present?
    next unless ENV["ROSALINA_TWITTER_ACESS_TOKEN_SECRET"].present?
    require "twitter"

    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = ENV["ROSALINA_TWITTER_CONSUMER_KEY"]
      config.consumer_secret      = ENV["ROSALINA_TWITTER_CONSUMER_SECRET"]
      config.access_token         = ENV["ROSALINA_TWITTER_ACESS_TOKEN"]
      config.access_token_secret  = ENV["ROSALINA_TWITTER_ACESS_TOKEN_SECRET"]
    end

    Post.joins(:source).includes(:source).where(sources: { post_to_twitter: true }, posted_to_twitter_at: nil).order("posts.created_at ASC").each do |post|
      # Pause to not be throttled by Twitter
      sleep 1
      begin
        client.update("#{post.source.name}: #{post.title} #{post.url}")
        post.update(posted_to_twitter_at: Time.now.utc)
      rescue => e
        Rails.logger.error("Post '#{post.id}' Failed to post to Twitter: #{e.message}")
      end
    end
  end
end
