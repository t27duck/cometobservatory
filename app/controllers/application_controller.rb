# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :page_setup

  private

  def page_setup
    @stored_source_ids = cookies.signed[:source_ids].present? ? JSON.parse(cookies.signed[:source_ids]) : []
    @grouped_sources = Source.where(sources: { active: true, site_visible: true}).order(:name).group_by(&:coverage)
  end
end
