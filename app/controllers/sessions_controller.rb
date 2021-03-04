class SessionsController < ApplicationController
  include JwtAuthenticater
  skip_before_action :authenticate_user, only: [:create, :show]

  def create
    @user = User.find_by(name: params[:name])
    if @user&.authenticate(params[:password])
      jwt_token = encode(@user.id)
      response.headers['X-Authentication-Token'] = jwt_token
      render json: {name: @user.name, team_id: @user.team_id}
    else
      render json: {error: "ニックネームまたはパスワードが違います"}, status: 400
    end
  end

  def show
    render json: {
      name: current_user&.name,
      team_id: current_user&.team&.id
    }
  end

end
