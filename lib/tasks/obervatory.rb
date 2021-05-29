# frozen_string_literal: true

namespace :obervatory do
  task fetch_pending: :environment do
    Source.find_each do |source|
      begin
        source.create_pending_posts
      rescue => e
        Rails.logger.error("#{source.name} - #{e.message}")
      end
    end
  end
end
