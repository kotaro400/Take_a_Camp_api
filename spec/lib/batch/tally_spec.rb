require 'rails_helper'
require_relative "../../../lib/batch/tally"

RSpec.describe Tally do
  describe "self.tally_votes" do
    context "初期状態" do
      context "誰も投票しない" do
        it "各チームの領土数は1" do
          Tally.tally_votes
          expect(Team.find(1).cells.length).to eq 1
          expect(Team.find(2).cells.length).to eq 1
        end
      end

      context "チーム1のひとりが[0, 1]に投票" do
        before do
          create(:vote, cell: Cell.find_by(row: 0, col: 1))
        end
        let(:cell){ Cell.find_by(row: 0, col: 1) }

        it "[0, 1]がチーム1の領土になる" do
          Tally.tally_votes
          expect(cell.team_id).to eq 1
        end

        it "チーム2には変化なし" do
          Tally.tally_votes
          expect(Team.find(2).cells.length).to eq 1
        end
      end

      context "チーム1のうちひとりが[0, 1]にもうひとりが[1, 0]に投票し、チーム2のふたりが[10, 9]に投票" do
        before do
          create(:vote, cell: Cell.find_by(row: 0, col: 1))
          create(:vote, cell: Cell.find_by(row: 1, col: 0))
          create_list(:vote, 2, :in_team_2, cell: Cell.find_by(row: 10, col: 9))
        end
        let(:cell_0_1){ Cell.find_by(row: 0, col: 1) }
        let(:cell_1_0){ Cell.find_by(row: 1, col: 0) }
        let(:cell_10_9){ Cell.find_by(row: 10, col: 9) }
        
        it "[0, 1]がチーム1の領土になる" do
          Tally.tally_votes
          expect(cell_0_1.team_id).to eq 1
        end

        it "[1, 0]がチーム1の領土になる" do
          Tally.tally_votes
          expect(cell_1_0.team_id).to eq 1
        end

        it "[10, 9]がチーム2の領土になる" do
          Tally.tally_votes
          expect(cell_10_9.team_id).to eq 2
        end
      end
    end

    context "両チームが中央に隣接後" do
      before do
        Cell.where(row: 1, col: 0)
        .or(Cell.where(row: 2, col: 0))
        .or(Cell.where(row: 3, col: 0))
        .or(Cell.where(row: 4, col: 0))
        .or(Cell.where(row: 5, col: 0))
        .or(Cell.where(row: 5, col: 1))
        .or(Cell.where(row: 5, col: 2))
        .or(Cell.where(row: 5, col: 3))
        .or(Cell.where(row: 5, col: 4)).update_all(team_id: 1)

        Cell.where(row: 9, col: 10)
        .or(Cell.where(row: 8, col: 10))
        .or(Cell.where(row: 7, col: 10))
        .or(Cell.where(row: 6, col: 10))
        .or(Cell.where(row: 5, col: 10))
        .or(Cell.where(row: 5, col: 9))
        .or(Cell.where(row: 5, col: 8))
        .or(Cell.where(row: 5, col: 7))
        .or(Cell.where(row: 5, col: 6)).update_all(team_id: 2)
      end
      let(:cell_5_5){ Cell.find_by(row: 5, col: 5) }

      context "両チームが中央に2票いれる" do
        before do
          create_list(:vote, 2, cell: Cell.find_by(row: 5, col: 5))
          create_list(:vote, 2, :in_team_2, cell: Cell.find_by(row: 5, col: 5))
        end

        it "中央はどのチームの領土にもならない" do
          Tally.tally_votes
          expect(cell_5_5.team_id).to eq nil
        end
      end

      context "チーム1が2票、チーム2が1票" do
        before do
          create_list(:vote, 2, cell: Cell.find_by(row: 5, col: 5))
          create(:vote, :in_team_2, cell: Cell.find_by(row: 5, col: 5))
        end

        it "中央がチーム1の領土になる" do
          Tally.tally_votes
          expect(cell_5_5.team_id).to eq 1
        end
      end
    end
  end
end
