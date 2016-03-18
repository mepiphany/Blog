class FavoritesController < ApplicationController

  def index
    @posts = current_user.favored_posts
  end

  def create
    @post = Post.friendly.find params[:post_id]
    favor = Favorite.new(post: @post, user: current_user)
    respond_to do |format|
      if favor.save
         format.html { redirect_to post_path(@post), notice: "Added to your favorite" }
         format.js { render :successful_favor }

      else
         format.html { redirect_to post_path(@post), alert: "it is already added to your favorite" }
         format.js { redner :unsuccessful_favor }
      end
    end
  end

  def destroy
    @post = Post.friendly.find params[:post_id]
    favor = current_user.favorites.find params[:id]
    respond_to do |format|
      favor.destroy
      format.html { redirect_to post_path(@post), alert: "removed!" }
      format.js { render }
   end
  end
end
