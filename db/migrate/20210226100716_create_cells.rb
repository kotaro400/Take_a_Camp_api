class CreateCells < ActiveRecord::Migration[6.0]
  def change
    create_table :cells do |t|
      t.integer :row, null: false
      t.integer :col, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
