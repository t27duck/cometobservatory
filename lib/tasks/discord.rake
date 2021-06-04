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
end
