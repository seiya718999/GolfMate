class Public::EventsController < ApplicationController
  before_action :authenticate_customer!, only: [:edit, :create, :update, :destroy]
  def index
    @events = Event.all
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
  end
  
  def create
    @event = Event.new(event_params)
    @event.customer_id = current_customer.id
    @event.save
    redirect_to events_path
  end

  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path
      flash[:notice] = "予定を更新しました"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
    flash[:notice] = "予定を削除しました"
  end
  
  private
  
  def event_params
    params.require(:event).permit(:schedule, :description, :date)
  end
  
end
