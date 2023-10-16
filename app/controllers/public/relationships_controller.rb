class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    customer = Customer.find(params[:customer_id])
    relationship = Relationship.new(follower_id: current_customer.id, followed_id: customer.id)
    relationship.save
    customer.create_notification_follow!(current_customer)
    redirect_to request.referer
  end
  
  def destroy
    customer = Customer.find(params[:customer_id])
    relationship = Relationship.find_by(follower_id: current_customer.id, followed_id: customer.id)
    relationship.destroy
    redirect_to request.referer
  end
  
  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings
  end

  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
  end
  
end
