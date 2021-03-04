class ApplicationController < ActionController::API
  include JwtAuthenticater

  before_action :authenticate_user

  def authenticate_user
    @current_user = current_user
    render json: {error: "ログインしてください"}, status: 401 unless @current_user
  end

  def current_user
    begin
      encoded_token = request.headers['Authorization'].split(' ').last
      payload = decode(encoded_token)
      puts payload
      User.find_by(id: payload["user_id"])
    rescue => exception
      puts "error"
      nil
    end
  end
end
