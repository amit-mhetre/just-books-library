class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate_user_from_token!
  before_action :ensure_params_exist, only: [:create]

  def create
    response = {}

    @user = User.find_for_database_authentication(email: user_params[:login])
    return invalid_login_attempt unless @user
    return invalid_login_attempt unless @user.valid_password?(user_params[:password])

    # Generating token based on login(i.e email) and password field
    @auth_token = jwt_token(user_params[:login], @user.encrypted_password)

    response[:status] = 200
    response[:message] = "Successfully signed in"
    response[:login] = user_params[:login]
    response[:token] = @auth_token

    render json: response
  end

  private

  def user_params
    params.require(:user).permit(:login, :password)
  end

  def ensure_params_exist
    if user_params.blank? || user_params[:login].blank? || user_params[:password].blank?
      response_json = {
        :status => 400,
        :errors => {
          :credentials => ["Incomplete credentials"]
        }
      }
      return render_unauthorized response_json
    end
  end

  def invalid_login_attempt
    response_json = {
      :status => 400,
      :errors => {
        :credentials => ["Invalid credentials"]
      }
    }
    return render_unauthorized response_json
  end
end
