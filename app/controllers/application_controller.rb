class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_cart

    def admin_required
        redirect_to '/', alert: 'You are not admin.' unless current_user.admin?
    end

    def current_cart
        @current_cart ||= find_cart
    end

    private


    def find_cart
        cart = Cart.find_by(id: session[:cart_id])
        if cart.blank?
            cart = Cart.create
        end
        session[:cart_id] = cart.id
        return cart
    end
end
