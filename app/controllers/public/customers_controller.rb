class Public::CustomersController < ApplicationController
  before_action :ensure_guest_customer, only: [:edit]
  
  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id)
    else
      render :edit
    end
  end
  
  def confirm
  end
  
  def withdrawal
  @customer = Customer.find(params[:id])
  
    if @customer.update(is_deleted: true)
      reset_session
      flash[:notice] = "ご利用ありがとうございました"
      redirect_to root_path
    else
      flash[:alert] = "アカウントの削除に失敗しました"
      render :edit
    end
  end
  
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :play_style, :average_score, :address, :gender, :introduction, :profile_image)
  end
  
  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.guest_user?
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
  
end
