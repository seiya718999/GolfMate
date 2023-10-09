class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end
  
  private

  def post_params
    params.require(:post).permit(:post_image, :body)
  end
  
end
