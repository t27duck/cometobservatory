# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def source_id_selected(source)
    return true if @stored_source_ids.blank?

    @stored_source_ids.include?(source.id.to_s)
  end
end
