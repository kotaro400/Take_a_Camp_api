#投票を集計するバッチ
class Tally
  def self.tally_votes
    #チームごとに最も投票数の多かったマスを決める
    all_selected_cells = []
    Team.all.each do |team|
      selected_cells_hash = team.votes.group_by{|vote| vote.cell_id }
      unless selected_cells_hash.empty?
        selected_cells_hash.each do |cell_id, votes|
          all_selected_cells.push({team_id: team.id, cell_id: cell_id, count: votes.length})
        end
      end
    end


    ActiveRecord::Base.transaction do
      #各チームが占領するマスをひとつ決定する。競合が起きたら投票数で勝負、防衛の場合は自陣側が二倍になる
      all_selected_cells.group_by{|cell| cell[:cell_id] }.each do |cell_id, teams|
        if teams.length > 1
          team_of_cell = Cell.find(cell_id).team
          winner_team = teams.map{|team| team_of_cell&.id == team[:team_id] ? team.merge({count: team[:count] * 2}) : team }.max_by{|team| team[:count]}
          Cell.find(cell_id).update!(team_id: winner_team[:team_id])
        else
          Cell.find(cell_id).update!(team_id: teams[0][:team_id])
        end
      end  

      #投票を全て削除する
      Vote.all.in_batches.each do |votes|
        votes.map{|vote| vote.destroy!} #例外を発生させるため
        sleep(0.1) #DBへの負担を減らす
      end
    end
  end
end