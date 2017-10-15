module Api
  module V1
    class BaseController < ActionController::API
      include ActionController::ImplicitRender
      respond_to :json

      before_action :authenticate_user_from_token!

      protected

      def current_user
        if @current_user.nil?
          if token_from_request.blank?
            nil
          else
            authenticate_user_from_token!
          end
        else
          @current_user
        end
      end
      alias_method :devise_current_user, :current_user

      def user_signed_in?
        !current_user.nil?
      end
      alias_method :devise_user_signed_in?, :user_signed_in?

      # Authenticate user using token
      def authenticate_user_from_token!
        if claims and user = User.find_by(email: claims[0]['user']) and user.encrypted_password == claims[0]['password']
          @current_user = user
        else
          return render_unauthorized
        end
      end

      # Decode token came from request header
      def claims
        JWT.decode(token_from_request, Rails.application.secrets.jwt_secret_key, true)
        rescue
          nil
      end

      # Generate tokem using JWT
      def jwt_token login, password = nil, provider_key = nil, provider_type = nil
        # 2 months
        expires = (Time.now + 2.months).to_i
        token = JWT.encode({:user => login, :password => password, :exp => expires}, Rails.application.secrets.jwt_secret_key, 'HS256')
        token = "Bearer #{token}"
      end

      # Render unauthorized access
      def render_unauthorized(payload = { errors: { unauthorized: ['You are not authorized perform this action.'] } })
        render json: payload, status: 200
      end

      def token_from_request
        # Accepts the token either from the header or a query var
        # Header authorization must be in the following format
        # Authorization: Bearer {yourtokenhere}
        auth_header = request.headers['Authorization'] and token = auth_header.split(' ').last
        if(token.to_s.empty?)
          token = request.parameters['token']
        end

        token
      end
    end
  end
end
