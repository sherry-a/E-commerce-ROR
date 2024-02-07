class AdminController < ApplicationController
  
  def show_users
    @users = User.all
  end

  def show_orders
    @orders = Order.all
  end

  def update_order
    @order = Order.find_by(id: params[:id])
    status = params[:status]

    if status == "Completed"
      @order.update(status: 1)
    else
      @order.update(status: 0)
    end

    redirect_to show_orders_path
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.orders.destroy_all
    @user.cart.orderables.destroy_all
    @user.cart.destroy
    @user.destroy

    redirect_to show_users_path
  end

end
