class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :check_xhr_header
  before_action :authenticate_user

  def authenticate_user
    render json: {error: "unauthorized"} unless current_user
  end

  def current_user
    @current_user = User.find_by(id: session[:user_id]) 
  end

  def check_xhr_header
    return if request.xhr?

    render json: { error: 'forbidden' }
  end
end
