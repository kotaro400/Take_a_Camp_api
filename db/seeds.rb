# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Team.create(
  [
    {id: 1},
    {id: 2}
  ]
)

(0..10).each do |row|
  (0..10).each do |col|
    if row == 0 && col == 0
      Cell.create(row: row, col: col, team_id: 1) 
    elsif row == 9 && col == 9
      Cell.create(row: row, col: col, team_id: 2)
    else
      Cell.create(row: row, col: col)
    end
  end
end
