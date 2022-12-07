class ReviewsController < ApplicationController

    def create
        review = Review.create(review_params.merge({user: @user}))
        if review.valid?
            render json: review, status: :created
        else
            render json: {error: "Failed to create product review."}
        end
    end

    def update
        review = find_review
        if review
           review.update(user_params)
           render json: review, status: :accepted
        else
            render_user_not_found_response
        end
       end
    
       def destroy
        review = find_review
        if review
           review.destroy
           head :no_content
        else
            render_user_not_found_response
        end
       end

    def review_params
        params.permit(:title, :product_id)
    end

    def find_review
        Review.find_by(id: params[:id])
    end
end
