class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    @user = User.new(name: params[:name], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      cookies.permanent.signed[:user_id] = @user.id
      render json: {name: @user.name}
    else
      render json: {error: @user.errors.full_messages}
    end
  end

end
