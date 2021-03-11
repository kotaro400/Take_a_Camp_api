require 'rails_helper'

RSpec.describe Cell, type: :model do
  describe "adjacent_cells" do
    it "[0, 0]の隣接マスは[1, 0], [0, 1]" do
      cell = Cell.find_by(row: 0, col: 0)
      expect(cell.adjacent_cells.map{|cell| [cell.row, cell.col] }).to contain_exactly([1, 0], [0, 1])
    end

    it "[5, 5]の隣接マスは[4, 5], [6, 5], [5, 4], [5, 6]" do
      cell = Cell.find_by(row: 5, col: 5)
      expect(cell.adjacent_cells.map{|cell| [cell.row, cell.col] }).to contain_exactly([4, 5], [6, 5], [5, 4], [5, 6])
    end

    it "[0, 5]の隣接マスは[1, 5], [0, 4], [0, 6]" do
      cell = Cell.find_by(row: 0, col: 5)
      expect(cell.adjacent_cells.map{|cell| [cell.row, cell.col] }).to contain_exactly([1, 5], [0, 4], [0, 6])
    end
  end

  describe "self.two_dimensional_array" do
    it "二次元配列から[0, 0]マスを取得できる" do
      expect(Cell.two_dimensional_array[0][0]).to eq Cell.find_by(row: 0, col: 0)
    end

    it "二次元配列から[5, 5]マスを取得できる" do
      expect(Cell.two_dimensional_array[5][5]).to eq Cell.find_by(row: 5, col: 5)
    end
  end
end
