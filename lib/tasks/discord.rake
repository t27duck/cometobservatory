# frozen_string_literal: true

namespace :discord do
  desc "Starts the Discord bot"
  task bot: :environment do
    raise "ROSALINA_BOT_TOKEN not set" unless ENV["ROSALINA_BOT_TOKEN"]

    require "discordrb"
    require "bot/codes_container"
    require "bot/ping_container"
    require "bot/weather_container"
    require "bot/pokedex_container"
    require "bot/sayings_container"
    require "bot/eight_ball_container"
    require "bot/coin_flip_container"

    bot = Discordrb::Commands::CommandBot.new(token: ENV["ROSALINA_BOT_TOKEN"], prefix: "%")
    bot.include! CodesContainer
    bot.include! PingContainer
    bot.include! PokedexContainer
    bot.include! SayingsContainer
    bot.include! EightBallContainer
    bot.include! CoinFlipContainer
    bot.include! WeatherContainer if ENV["WEATHERSTACK_KEY"]
    bot.run
  end

  task post_to_webhook: :environment do
    next unless ENV["ROSALINA_ALL_NEWS_WEBHOOK"].present?
    require "discordrb/webhooks"

    client = Discordrb::Webhooks::Client.new(url: ENV["ROSALINA_ALL_NEWS_WEBHOOK"])

    Post.joins(:source).includes(:source).where(sources: { post_to_discord: true }, posted_to_discord_at: nil).order("posts.created_at ASC").each do |post|
      # Pause to not be throttled by Discord
      sleep 1
      username = "New Post from #{post.source.name}"
      client.execute do |builder|
        builder.username = username
        builder.add_embed do |embed|
          embed.title = post.title
          embed.url = post.url
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(
            text: "posted by #{post.author.presence || 'N/A'}",
            icon_url: "https://cometobservatory.net/images/sources/#{post.source.image_filename}"
          )
        end
      end
      post.update(posted_to_discord_at: Time.now.utc)
    end
  end
end
