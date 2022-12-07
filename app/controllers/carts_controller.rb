class CartsController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        cart = Cart.create(cart_params.merge({user: @user}))
           
        if cart.valid?
                render json: cart, status: :created
        else
                render json: {error: "Failed to create cart"}
        end
    end

    def index
        if @user.profile.is_admin
            carts = Cart.all
           
            if carts
                render json: carts, status: :ok
            else
                render_cart_not_found_response
            end
        else
            render json: {error: "Only admin is authorized to do that!"}
        end
    end

    def show
        cart = Cart.where({user_id: @user.id})

        if cart
            render json: cart, status: :ok
        else
            render_cart_not_found_response
        end
    end

    def update
        
        cart = cart_params
           
        if cart
                cart.update(cart_params)
                render json: cart, status: :accepted
        else
                render_cart_not_found_response
        end
       
    end

    def destroy 
        
            cart = cart_params
           
            if cart
                cart.destroy
                render json: {}
            else
                render_cart_not_found_response
            end
       
    end

    private

    def cart_params
        params.permit(:quantity, :total, :order_id, :product_id)
    end

    def find_cart
        Cart.find_by(id: params[:id])
    end

    def render_cart_not_found_response
        render json: {error: "Cart is not available."}
    end
end
