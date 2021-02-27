class VotesController < ApplicationController

  def create
    @vote = current_user.votes.build(cell_id: params[:cell_id])
    if @vote.save
      render json: {}
    else
      render json: {error: "error"}, status: 500
    end
  end

end
