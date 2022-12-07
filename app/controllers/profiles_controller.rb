class ProfilesController < ApplicationController
    before_action :authorized

    def create
        profile = Profile.create(profile_params.merge(user: @user))
        if profile.valid?
            render json: profile, status: :created
        else
            render json: {error: "Failed to create user profile."}
        end
    end

    def index
        profiles = Profile.all
        render json: profiles, status: :ok 
    end

    private
    def profile_params
        params.permit(:image, :phone, :address )
    end

end
