class ApplicationController < ActionController::Base
    before_action :initialize_cart
    before_action :configure_permitted_parameters, if:  :devise_controller?

    def initialize_cart
        if current_user && current_user.role == 0
            @user = User.find_by(id: current_user.id)
            @cart = @user.cart    
            
            if @cart.nil?
                @cart = @user.create_cart
                session[:cart_id] = @cart.id
            end
        end
    end


protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}

        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
    end
end