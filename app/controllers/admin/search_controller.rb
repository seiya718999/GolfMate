class Admin::SearchController < ApplicationController
  before_action :authenticate_admin!
  
  def customers_search
    @content = params[:content]
    @method = params[:method]
    @records = Customer.search_for(@content)
  end
  
  
  def posts_search
    @content = params[:content]
    @records = Post.search_for(@content)
  end
end
