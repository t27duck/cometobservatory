# frozen_string_literal: true

class FeedsController < ApplicationController
  def index
    @sources = Source.where(source_class: "RssFeed", active: true, site_visible: true).order(:name)
  end

  def show
    respond_to do |format|
      format.xml do
        @feed_title = "Comet Observatory Feed"
        @feed_description = "Latest Nintendo and Industry-Wide News Headlines"
        @posts = Post.includes(:source).joins(:source).where(sources: { active: true, site_visible: true}).order(created_at: :desc)
      end
      format.html { redirect_to root_path }
    end
  end
end
