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
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  load_and_authorize_resource
  skip_authorize_resource only: :show


  def index
    @posts = Post.all.page(params[:page]).per(10)
  end


  def new
    @post = Post.new
  end

  def create
    @post.user = current_user
    if @post.save
       redirect_to post_path(@post), notice: "Your post has been successfully uploaded"
    else
      flash[:alert] = "Your post is not created, please check the errors below"
      render :new
    end
  end

  def show
    @comment = Comment.new
    # @comments = @post.comments
  end

  def edit;end

  def update
    @post.slug = nil
    if @post.update post_params
      redirect_to post_path(@post), notice: "Your post has been updated!"
    else
      flash[:alert] = "Your post it not updated!"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    params.require(:post).permit([:title, :body, :category_id, :user_id, {images: []}, :file])
  end
end
