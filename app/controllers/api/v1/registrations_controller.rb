module Api
  module V1
    class RegistrationsController < Api::V1::BaseController
      skip_before_action :authenticate_user_from_token!
      def create
        response_json = {}
        @user = User.new(user_params)
        if @user.save
          @auth_token = jwt_token(@user, user_params['password'])
          response_json[:status] = 200
          response_json[:message] = 'Successfully signed up'
          response_json[:email] = user_params[:email]
        else
          response_json[:status] = 422
          response_json[:errors] = @user.errors
        end
        render json: response_json
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
