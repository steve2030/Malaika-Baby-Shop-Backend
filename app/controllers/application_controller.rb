class ApplicationController < ActionController::API
    before_action :authorized

    def encode_token(payload, expiration)
        payload[:exp] = expiration
        JWT.encode(payload, "secret")
    end

    def decode_token
        auth_header = request.headers["Authorization"];
  \
        if auth_header
            token = auth_header.split(" ")[1]
            begin
                JWT.decode(token, "secret", algorithm: "HS256")
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def authorize_user
        if decode_token
            user_id = decode_token[0]["user_id"]
            @user = User.find_by(id: user_id)
        end
    end

    def authorized
        render json: {message: "You have to log in."}, status: :unauthorized unless authorize_user
    end

    private

    


end
