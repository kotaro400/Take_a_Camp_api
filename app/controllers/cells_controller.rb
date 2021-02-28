class CellsController < ApplicationController
  
  def index
    render json: {
      cells: Cell.two_dimensional_array,
      voted_cell: current_user.votes&.first&.cell
    } 
  end

end
