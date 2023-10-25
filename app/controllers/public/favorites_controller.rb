class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @favorites = current_customer.favorites
    @posts = Post.where(id: @favorites.pluck(:post_id))
  end
  
  def create
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new
    favorite.post_id = @post.id
    favorite.save
    post = Post.find(params[:post_id])
    post.create_notification_like!(current_customer)
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
  
end
