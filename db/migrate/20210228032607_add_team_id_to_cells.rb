class AddTeamIdToCells < ActiveRecord::Migration[6.0]
  def change
    remove_column :cells, :status, :integer
    add_reference :cells, :team, foreign_key: true
  end
end
