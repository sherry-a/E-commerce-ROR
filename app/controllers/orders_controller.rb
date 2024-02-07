class OrdersController < ApplicationController

  def show
  end

  def add
    total_products = params[:total_products]
    address = params[:address]
    @order = current_user.orders.create(user_id: current_user.id, total_price: @cart.total, total_products: total_products, address: address, status: 0)

    if @order.save
      @cart.orderables.destroy_all
      flash[:notice] = "Order has been placed successfully"
      redirect_to root_path
    end

  end

end
