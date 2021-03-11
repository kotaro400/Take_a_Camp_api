require 'rails_helper'

RSpec.describe Team, type: :model do
  describe "adjacent_cells" do
    it "自領土と自領土に隣接している全てのマスを返す" do
      expect(Team.find(1).adjacent_cells.map{|cell| [cell.row, cell.col] }).to contain_exactly([0, 0], [0, 1], [1, 0])
    end
  end

  describe "votes" do
    it "所属メンバー全員の投票を返す" do
      voted_cell = Cell.find_by(row: 0, col: 1)
      create_list(:vote, 3, cell: voted_cell)
      expect(Team.find(1).votes.length).to eq 3
    end
  end

  describe "point" do
    it "初期状態のポイントは1" do
      expect(Team.find(1).point).to eq 1
    end
  end
end
