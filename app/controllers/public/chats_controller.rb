class Public::ChatsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @group = Group.find(params[:group_id])
    @chat = @group.chats.new(chat_params)
    @chat.customer_id = current_customer.id
    if @chat.save
      redirect_to group_path(@group)
    else
      render :index
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:content)
  end

end
