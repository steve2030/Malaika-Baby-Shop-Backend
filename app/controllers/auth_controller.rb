class AuthController < ApplicationController
    skip_before_action :authorized, only: [:register, :login]

    def register
        @user = User.create(user_register_params);

        if @user.valid?
           
            render json: {user: UserSerializer.new(@user)}, status: :created;
        else
            render json: {error: "User was not created"}, status: :unprocessable_entity
        end
    end

    def login
        @user = User.find_by(username: user_login_params[:username])

        if @user && @user.authenticate(user_login_params[:password])
            token = encode_token({user_id: @user.id}, Time.now.to_i + 432000);
            render json: {user: UserSerializer.new(@user), token: token}, status: :ok;
        else
            render json: {error: "Invalid username or password"}, status: :unprocessable_entity
        end
    end

    private

    def user_register_params
        params.permit(:first_name, :last_name, :username, :email, :password)
    end

    def user_login_params
        params.permit(:username, :password)
    end
    
end
