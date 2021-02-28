class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    @user = User.new(name: params[:name], password: params[:password], team_id: rand(1..2))
    if @user.save
      session[:user_id] = @user.id
      cookies.permanent.signed[:user_id] = @user.id
      render json: {name: @user.name, team_id: @user.team_id}
    else
      render json: {error: @user.errors.full_messages}, status: 400
    end
  end

end
