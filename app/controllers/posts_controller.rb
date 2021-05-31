# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.includes(:source).order(created_at: :desc)
    @posts = @posts.where(source_id: JSON.parse(cookies.signed[:source_ids])) if cookies.signed[:source_ids].present?
    @page = (params[:page] || 1).to_i
    @pagy, @posts = pagy_countless(@posts, items: 20)
    @stored_source_ids = cookies.signed[:source_ids].present? ? JSON.parse(cookies.signed[:source_ids]) : []
    @grouped_sources = Source.order(:name).group_by(&:coverage)
  end

  def create
    if params[:source_ids].present?
      if params[:source_ids].size == Source.count
        cookies.delete(:source_ids)
      else
        cookies.signed.permanent[:source_ids] = JSON.generate(params[:source_ids])
      end
    else
      cookies.delete(:source_ids)
    end

    redirect_to root_path
  end
end
