class VotesController < ApplicationController

  def create
    @vote = current_user.votes.build(cell_id: params[:cell_id])
    if @vote.save
      render json: @vote
    else
      render json: {error: @vote.errors.full_messages}, status: 400
    end
  end

end
