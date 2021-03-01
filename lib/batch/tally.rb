#投票を集計するバッチ
class Tally
  def self.tally_votes
    ActiveRecord::Base.transaction do
      #各チームが占領するマスをひとつ決定する
      Team.all.each do |team|
        selected_cell = team.votes.group_by{|vote| vote.cell_id }.max_by{|cell_id, votes| votes.length }
        if selected_cell
          Cell.find(selected_cell[0]).update!(team_id: team.id)
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