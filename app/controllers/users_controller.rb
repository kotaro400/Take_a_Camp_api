class UsersController < ApplicationController
  include JwtAuthenticater
  skip_before_action :authenticate_user, only: [:create]

  def create
    @user = User.new(name: params[:name], password: params[:password], team_id: rand(1..2))
    if @user.save
      jwt_token = encode(@user.id)
      response.headers['X-Authentication-Token'] = jwt_token
      render json: {name: @user.name, team_id: @user.team_id}
    else
      render json: {error: @user.errors.full_messages}, status: 400
    end
  end

end
