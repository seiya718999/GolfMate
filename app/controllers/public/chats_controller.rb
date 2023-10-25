class Public::ChatsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @group = Group.find(params[:group_id])
    @chats = @group.chats.order(created_at: :desc)
    @chat = @group.chats.new(chat_params)
    @chat.customer_id = current_customer.id
    unless  @chat.save
      render :index
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:content)
  end

end
