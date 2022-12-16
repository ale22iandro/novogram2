class HomeController < ApplicationController
  def index
    @pagy, @posts = pagy(Post.order(created_at: :desc), items: 5)
  end
end
