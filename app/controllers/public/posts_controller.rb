class Public::PostsController < ApplicationController
  def new
  end

  def index
    @posts = Post.all
    
  end

  def show
  end

  def edit
  end
  
  private

  def post_params
    params.require(:customer).permit(:last_name, :first_name)
  end
  
end
