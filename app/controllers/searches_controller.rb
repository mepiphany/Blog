class SearchesController < ApplicationController
  def index
    @search = Post.search params[:search]

  end
end
