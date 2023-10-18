class Public::EventsController < ApplicationController
  before_action :authenticate_customer!, only: [:edit, :create, :update, :destroy]
  def index
    @customer = Customer.find(params[:customer_id])
    @events = @customer.events
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
    unless @event.customer_id == current_customer.id
      redirect_to request.referrer || root_path
    end
  end
  
  def create
    @event = Event.new(event_params)
    @event.customer_id = current_customer.id
    @event.save
    redirect_to customer_events_path
  end

  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to customer_events_path
      flash[:notice] = "予定を更新しました"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to customer_events_path
    flash[:notice] = "予定を削除しました"
  end
  
  def search
    @group = Group.find(params[:group_id])
    if  params[:start_date]
      start_date = params[:start_date].to_date
      end_date = params[:end_date].to_date
      @date_range = (start_date..end_date).to_a
      
      group_id = params[:group_id]
      @group_members = @group.customers
      
      member = GroupCustomer.where(group_id: group_id).pluck(:customer_id)
      available_status = Event.schedules[:available] 
      @available_events = Event.where(customer_id: member, schedule: :available, date: start_date..end_date)
    end
  end
  
  private
  
  def event_params
    params.require(:event).permit(:schedule, :description, :date)
  end
  
end
