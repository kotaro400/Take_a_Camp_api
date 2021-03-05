# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Vote.destroy_all

Cell.destroy_all

User.destroy_all

Team.destroy_all

Team.create(
  [
    {id: 1},
    {id: 2}
  ]
)

(0..10).each do |row|
  (0..10).each do |col|
    if row == 0 && col == 0
      Cell.create(row: row, col: col, team_id: 1, point: 1) 
    elsif row == 10 && col == 10
      Cell.create(row: row, col: col, team_id: 2, point: 1)
    elsif row == 5 && col == 5
      Cell.create(row: row, col: col, point: 10)
    elsif row == 1 && col == 5
      Cell.create(row: row, col: col, point: 5)
    elsif row == 5 && col == 1
      Cell.create(row: row, col: col, point: 5)
    elsif row == 9 && col == 5
      Cell.create(row: row, col: col, point: 5)
    elsif row == 5 && col == 9
      Cell.create(row: row, col: col, point: 5)
    else
      Cell.create(row: row, col: col, point: 1)
    end
  end
end
