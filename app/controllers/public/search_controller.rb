class Public::SearchController < ApplicationController
  
  def customers_search
    @content = params[:content]
    @records = Customer.search_for(@content)
  end
  
  
  def posts_search
    @content = params[:content]
    @records = Post.search_for(@content)
  end
end
