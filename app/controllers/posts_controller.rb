# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostsController < ApplicationController

  def index
    @posts = Post.all.page(params[:page]).per(10)
  end


  def new
    @post = Post.new

  end

  def create
    post_params = params.require(:post).permit([:title, :body, :category_id])
    @post = Post.new(post_params)
    if @post.save
       redirect_to post_path(@post), notice: "Your post has been successfully uploaded"
    else
      flash[:alert] = "Your post is not created, please check the errors below"
      render :new
    end
  end

  def show
    @post = Post.find params[:id]
    @comments = Comment.new
    # @comments = @post.comments

  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    post_params = params.require(:post).permit([:title, :body, :category_id])
    @post = Post.find params[:id]
    @post.update post_params
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy

    redirect_to posts_path, notice: "Post Deleted!"


  end
end
