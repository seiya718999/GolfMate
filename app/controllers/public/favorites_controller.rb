class Public::FavoritesController < ApplicationController
  
  def index
    @favorites = current_customer.favorites
    @posts = Post.where(id: @favorites.pluck(:post_id))
  end
  
  def create
    favorite = current_customer.favorites.new
    favorite.post_id = params[:post_id]
    favorite.save
    redirect_to request.referer
  end
  
  def destroy
    favorite = current_customer.favorites.find_by(post_id: params[:post_id])
    favorite.destroy
    redirect_to request.referer
  end
  
end
