class PagesController < ApplicationController
  def home
    @products = Product.last(5)
  end

  def search
    @query = params[:query]
    
    if !@query.empty? 
      @products = Product.where("products.name LIKE ?", ["%#{@query}%"])
      render "products/index"
    end
  end

end
