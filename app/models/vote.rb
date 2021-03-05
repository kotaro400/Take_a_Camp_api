class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :cell

  validates :user_id, uniqueness: true
  validate :validate_adjacency
  validate :validate_no_obstacle

  private
  def validate_adjacency
    errors.add(:base, "自領土か隣接しているマスを選択してください") unless user.team.adjacent_cells.include?(cell)
  end

  def validate_no_obstacle
    errors.add(:base, "障害物があります") if [4, 6].include?(cell.row) && [4, 6].include?(cell.col)
  end

end
