class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    @user = User.find_by(name: params[:name])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      cookies.permanent.signed[:user_id] = @user.id  
      render json: {name: @user.name, team_id: @user.team_id}
    else
      render json: {error: "error"}, status: 400
    end
  end

  def destroy
    session.delete(:user_id)
    render json: {message: "signed out"}
  end

end
