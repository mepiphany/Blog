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
  def index
    @comments = Comment.all

  end

  def new
    # @comment = Comment.new
  end

  def create
    # need to get the post_id
    @post = Post.find params[:post_id]
    # need to store
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new(comment_params)
    # The following code is creating post_id
    # @comment.post_id = @post.id (both are same)
    @comment.post = @post
    @comment.save
    redirect_to post_path(@post)

  end

  def show
    @comment = Comment.find params[:id]
  end

  def edit
    @comment = Comment.find params[:id]
  end

  def update
    comment_params = params.require(:comment).permit([:body])
    @comment = Comment.find params[:id]
    if @comment.update(comment_params)
      redirect_to comment_path(@comment), notice: "Your comment has been updated!"
    else
      flash[:alert] = "Your comment is not updated!"
      render :edit
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to post_path(params[:post_id]), notice: "Comment Deleted!"
  end

end
