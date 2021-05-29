# frozen_string_literal: true

class CreateInitialSources < ActiveRecord::Migration[6.1]
  def up
    add_column :sources, :coverage, :string

    Source.create!(
      name: "IGN Switch Articles",
      url: "http://feeds.feedburner.com/ign-nintendo-switch-articles",
      source_class: "RssFeed",
      image_filename: "ign.png",
      coverage: "Nintendo"
    )

    Source.create!(
      name: "GameSpot",
      url: "https://www.gamespot.com/feeds/game-news",
      source_class: "RssFeed",
      image_filename: "gamespot.png",
      coverage: "Industry-Wide"
    )

    Source.create!(
      name: "Gamasutra",
      url: "http://feeds.feedburner.com/GamasutraNews",
      source_class: "RssFeed",
      image_filename: "gamasutra.png",
      coverage: "Industry-Wide"
    )

    Source.create!(
      name: "Nintendo Everything",
      url: "http://nintendoeverything.com/feed",
      source_class: "RssFeed",
      image_filename: "nintendoeverything.png",
      coverage: "Nintendo"
    )

    Source.create!(
      name: "My Nintendo News",
      url: "https://mynintendonews.com/feed/",
      source_class: "RssFeed",
      image_filename: "mynintendonews.png",
      coverage: "Nintendo"
    )

    Source.create!(
      name: "Nintendo Insider",
      url: "https://www.nintendo-insider.com/feed/",
      source_class: "RssFeed",
      image_filename: "nintendoinsider.png",
      coverage: "Nintendo"
    )

    change_column_null :sources, :coverage, false
  end

  def down
    remove_column :sources, :coverage
    Sources.destroy_all
  end
end
