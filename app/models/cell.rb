class Cell < ApplicationRecord
  has_many :votes
  belongs_to :team, optional: true

  def self.two_dimensional_array
    result = []
    11.times.each do |n|
      result.push(Cell.where(row: n).order(:col))
    end
    result
  end

  def adjacent_cells
    Cell.where(row: row, col: col + 1)
    .or(Cell.where(row: row, col: col - 1))
    .or(Cell.where(row: row + 1, col: col))
    .or(Cell.where(row: row - 1, col: col))
  end

end
