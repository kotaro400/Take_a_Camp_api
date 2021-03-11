require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe "バリデーション" do
    describe "validate_adjacency" do
      it "自領土内のマスには投票できる" do
        vote = build(:vote, cell: Cell.find_by(row: 0, col: 0))
        expect(vote).to be_valid
      end

      it "自領土に隣接しているマスにも投票可能" do
        vote = build(:vote, cell: Cell.find_by(row: 1, col: 0))
        expect(vote).to be_valid
      end

      it "自領土に隣接していないマスには投票できない" do
        vote = build(:vote, cell: Cell.find_by(row: 5, col: 5))
        expect(vote).not_to be_valid
      end
    end

    describe "validate_no_obstacle" do
      before do
        Cell.where(row: 1, col: 0)
        .or(Cell.where(row: 2, col: 0))
        .or(Cell.where(row: 3, col: 0))
        .or(Cell.where(row: 4, col: 0))
        .or(Cell.where(row: 4, col: 1))
        .or(Cell.where(row: 4, col: 2))
        .or(Cell.where(row: 4, col: 3)).update_all(team_id: 1)
      end

      it "[4, 6]には投票できない" do
        vote = build(:vote, cell: Cell.find_by(row: 4, col: 6))
        expect(vote).not_to be_valid
      end

      it "[4, 4]には投票できない" do
        vote = build(:vote, cell: Cell.find_by(row: 4, col: 4))
        expect(vote).not_to be_valid
      end

      it "[6, 6]には投票できない" do
        vote = build(:vote, cell: Cell.find_by(row: 6, col: 6))
        expect(vote).not_to be_valid
      end

      it "[6, 4]には投票できない" do
        vote = build(:vote, cell: Cell.find_by(row: 6, col: 4))
        expect(vote).not_to be_valid
      end
    end
  end
end
