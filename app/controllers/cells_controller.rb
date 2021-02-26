class CellsController < ApplicationController
  
  def index
    render json: {
      cells: Cell.two_dimensional_array
    } 
  end

end
