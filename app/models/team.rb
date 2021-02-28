class Team < ApplicationRecord
  has_many :cells
  has_many :users

  def adjacent_cells
    cells.map{|cell| cell.adjacent_cells }.flatten.uniq.delete_if{|cell| cells.include?(cell)}
  end
end
