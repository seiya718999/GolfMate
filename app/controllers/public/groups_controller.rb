class Public::GroupsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @group =Group.new
  end

  def index
    @groups = current_customer.groups
  end

  def show
    @group = Group.find(params[:id])
    @customers = @group.customers
  end
  
  def create
    @group = Group.new(group_params)
    if @group.save
      group_customer = current_customer.group_customers.create(group_id: @group.id)
      if group_customer.persisted?
        redirect_to groups_path
      else
        @group.destroy
        render 'new'
      end
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

end
