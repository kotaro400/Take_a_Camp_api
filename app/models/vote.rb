class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :cell

  validates :user_id, uniqueness: true
  validate :validate_adjacency

  private
  def validate_adjacency
    errors.add(:base, "自領土か隣接しているマスを選択してください") unless user.team.adjacent_cells.include?(cell)
  end

end
