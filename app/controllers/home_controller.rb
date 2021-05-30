# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts = Post.includes(:source)
    @page = (params[:page] || 1).to_i
    @pagy, @posts = pagy_countless(@posts.order(created_at: :desc), items: 20)
  end
end
