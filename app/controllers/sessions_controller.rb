class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create, :show]

  def create
    @user = User.find_by(name: params[:name])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      cookies.permanent.signed[:user_id] = {
        value: @user.id,
        httponly: true,
        domain: "herokuapp.com",
        secure: true
      } 
      render json: {name: @user.name, team_id: @user.team_id}
    else
      render json: {error: "ニックネームまたはパスワードが違います"}, status: 400
    end
  end

  def destroy
    session.delete(:user_id)
    render json: {message: "signed out"}
  end

  def show
    render json: {
      name: current_user&.name,
      team_id: current_user&.team&.id
    }
  end

end
