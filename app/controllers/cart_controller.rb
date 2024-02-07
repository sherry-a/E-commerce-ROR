class CartController < ApplicationController
  
  def show
  end

  def add
    @product = Product.find(params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(product_id: @product.id)

    if current_orderable && quantity > 0
      current_orderable.update(quantity: quantity)
    elsif quantity <= 0
      current_orderable.destroy
    else
      @cart.orderables.create(product: @product, quantity: quantity)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart }),
                              turbo_stream.replace(@product,),
                              turbo_stream.replace('cart_count', partial: 'cart/cart_count', locals: { cart: @cart}),
                              turbo_stream.replace('grand_total', partial: 'cart/grand_total', locals: { cart: @cart}),
                              turbo_stream.replace('checkout', partial: 'checkout/checkout', locals: { cart: @cart}),]
                                                               # here @product because in _products.html.erb it already has the dom id for the product so it can figure it out on its own
      end                                                      # main reason for replacing is because we are updating our product quantities
    end

  end

  def remove
    Orderable.find_by(id: params[:id]).destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart }),
                              turbo_stream.replace('cart_count', partial: 'cart/cart_count', locals: { cart: @cart}),
                              turbo_stream.replace('grand_total', partial: 'cart/grand_total', locals: { cart: @cart}),
                              turbo_stream.replace('checkout', partial: 'checkout/checkout', locals: { cart: @cart}),]
      end
    end
  end

end
