# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  body       :text
#

class CommentsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :find_post, only: [:show, :edit, :update, :delete]
  load_and_authorize_resource


  def index
    @comments = Comment.all

  end

  def new
    # @comment = Comment.new
  end

  def create
    @post = Post.friendly.find params[:post_id]
    # need to get the post_id
    # need to store
    @comment = Comment.new(comment_params)
    # The following code is creating post_id
    # @comment.post_id = @post.id (both are same)
    @comment.post = @post
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        #  CommentsMailer.notify_post_owner(@comment).deliver_later
         format.html {redirect_to post_path(@post), notice: "You have commented!"}
         format.js { render :successful_comment}
      else
         format.html {render :new}
         format.js { render :unsucessful_comment}
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @post.slug = nil
    if @comment.update(comment_params)
      redirect_to comment_path(@comment), notice: "Your comment has been updated!"
    else
      flash[:alert] = "Your comment is not updated!"
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      @comment.destroy
      format.html {redirect_to post_path(params[:post_id]), notice: "Comment Deleted!"}
      format.js {render}
    end
  end

  private

  def find_post
    @post = Post.friendly.find(params[:post_id])
  end

  def comment_params
     params.require(:comment).permit([:body])
  end

end
