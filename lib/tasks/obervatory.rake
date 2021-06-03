# frozen_string_literal: true

namespace :observatory do
  task fetch: :environment do
    Rake::Task["observatory:fetch_pending"].invoke
    Rake::Task["observatory:process_pending"].invoke
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
end
