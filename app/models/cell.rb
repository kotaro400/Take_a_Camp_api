class Cell < ApplicationRecord
  has_many :votes

  def self.two_dimensional_array
    result = []
    5.times.each do |n|
      result.push(Cell.where(row: n).order(:col))
    end
    result
  end

end
