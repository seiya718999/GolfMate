class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = current_customer.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:notice] = "コメントしました。"
      redirect_to post_path(@comment.post_id)
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "コメントを編集しました。"
      redirect_to post_path(@comment.post_id)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "コメントを削除しました。"
      redirect_to post_path(@comment.post_id)
    else
      flash[:notice] = "コメントの削除に失敗しました。"
      redirect_to post_path(@comment.post_id)
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
