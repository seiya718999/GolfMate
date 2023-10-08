class SearchController < ApplicationController
  
  def customers_search
    @content = params[:content]
    @method = params[:method]
    @records = Customer.search_for(@content, @method)
  end
  def posts_search
    @content = params[:content]
    @method = params[:method]
    @records = Post.search_for(@content, @method)
  end
end
