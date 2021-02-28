class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :cell

  validates :user_id, uniqueness: true
  validate :validate_adjacency

  private
  def validate_adjacency
    errors.add(:base) unless user.team.adjacent_cells.include?(cell)
  end

end
