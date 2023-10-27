class Public::GroupCustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    if params[:content]
      @group = Group.find(params[:group_id])
      @content = params[:content]
      records = Customer.search_for(@content)
      group_member = @group.customers.pluck(:id)
      @customers = records.where.not(id: group_member).where(is_deleted: false)
    else
      @group = Group.find(params[:group_id])
      group_member = @group.customers.pluck(:id)
      @customers = Customer.where.not(id: group_member).where(is_deleted: false)
    end
  end
  
  def create
    customer = Customer.find(params[:id])
    group_customer = customer.group_customers.new(group_id: params[:group_id])
    group_customer.save
    redirect_to request.referer
  end
  
  def destroy
    customer = Customer.find(params[:id])
    group_customer = customer.group_customers.find_by(group_id: params[:group_id])
    group_customer.destroy
    redirect_to request.referer
  end
  
  
end