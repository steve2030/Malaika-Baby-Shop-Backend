class OrdersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        order = Order.create(order_params.merge({user: @user}))
           
        if order.valid?
            render json: order, status: :created
        else
            render json: {error: "Failed to create order"}
        end
    end

    def index
        if @user.profile.is_admin
            orders = Order.all
            if orders
                render json: orders, status: :ok
            else
                render_order_not_found_response
            end
        else
            render json: {error: "Only admin is authorized to do that!"}
        end
    end

    def show
        order = Order.where({user_id: @user.id})
        if order
            render json: order, status: :ok
        else
            render_order_not_found_response
        end
    end

    def update
        
        if @user.profile.is_admin
            order = find_order
           
            if order
                order.update(order_params)
                render json: order, status: :accepted
            else
                render_order_not_found_response  
            end
        else
            render json: {error: "Only admin is authorized to do that!"}
        end
       
    end

    def destroy 
        
        if @user.profile.is_admin
            order = find_order
           
            if order
                order.destroy
                render json: {}
            else
                render_order_not_found_response
            end
        else
            render json: {error: "Only admin is authorized to do that!"}
        end
       
    end

    private

    def order_params
        params.permit(:amount, :address, :product_id)
    end

    def find_order
        Order.find_by(id: params[:id])
    end

    def render_order_not_found_response
        render json: {error: "order is not available."}
    end
end
