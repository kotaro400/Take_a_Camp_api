class AddPointToCells < ActiveRecord::Migration[6.0]
  def change
    add_column :cells, :point, :integer, null: false
  end
end
