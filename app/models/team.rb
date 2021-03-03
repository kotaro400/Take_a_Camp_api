class Team < ApplicationRecord
  has_many :cells
  has_many :users

  def adjacent_cells
    cells.map{|cell| cell.adjacent_cells.to_a << cell }.flatten.uniq
  end

  def votes
    users.map{|user| user.votes }.flatten
  end

  def point
    cells.map{|cell| cell.point }.sum
  end
end
