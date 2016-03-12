class FavoritesController < ApplicationController

  def index
    @posts = current_user.favored_posts

  end

  def create
    post = Post.find params[:post_id]
    favor = Favorite.new(post: post, user: current_user)
    if favor.save
       redirect_to post_path(post), notice: "Added to your favorite"
    else
      redirect_to post_path(post), alert: "it is already added to your favorite"
     end
  end

  def destroy
    @post = Post.find params[:post_id]
    favor = current_user.favorites.find params[:id]
    favor.destroy
    redirect_to post_path(@post), alert: "removed!"
  end
end
