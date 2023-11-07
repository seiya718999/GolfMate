class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :edit, :create, :update, :destroy]
  before_action :is_matching_login_customer, only: [:edit, :update]
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    sentiment_score = Language.get_data(post_params[:body])
    Rails.logger.info "Sentiment Analysis Result: #{sentiment_score.inspect}"
    
    unless sentiment_score && sentiment_score['documentSentiment']['score'] > -0.5
      flash[:alert] = '内容が不適切な可能性があります。'
      render :new
      return
    end
    
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to customer_path(current_customer.id)
    else
      render :show
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:post_image, :body)
  end
  
  def is_matching_login_customer
    if current_customer
      post = Post.find(params[:id])
      customer = post.customer
      unless customer.id == current_customer.id
        redirect_to posts_path
      end
    end
  end
  
end
