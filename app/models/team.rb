class Team < ApplicationRecord
  has_many :cells
  has_many :users

  def adjacent_cells
    cells.map{|cell| cell.adjacent_cells << cell }.flatten.uniq
  end

  def votes
    users.map{|user| user.votes }.flatten
  end
end
