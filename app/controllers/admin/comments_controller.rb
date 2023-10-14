class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "コメントを編集しました。"
      redirect_to admin_post_path(@comment.post_id)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "コメントを削除しました。"
      redirect_to admin_post_path(@comment.post_id)
    else
      flash[:notice] = "コメントの削除に失敗しました。"
      redirect_to admin_post_path(@comment.post_id)
    end
  end
  
   private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
end
