set :output, 'log/crontab.log'
set :environment, :development
set :runner_command, "rails runner"
#環境変数を渡す、これをしないとDocker上で動かない
ENV.each { |k, v| env(k, v) }

every 1.minute do
  runner 'Tally.tally_votes'
end
