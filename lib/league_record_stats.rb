module LeagueRecordStats
  def total_win_loss_records
    @league.teams.inject({}) do |home_loss_records, team|
      home_loss_records[team.team_name] = []
      @league.games.each do |game| 
        team_goals = home_loss_records[team.team_name]
        if team.team_id == game.away_team_id
          game.outcome.include?("away") ?
          team_goals << 1 : team_goals << 0
        elsif team.team_id == game.home_team_id
          game.outcome.include?("home") ?
          team_goals << 1 : team_goals << 0
        else 
          next
        end
      end
      if home_loss_records[team.team_name].count.zero?
        home_loss_records.delete(team.team_name)
      end
      home_loss_records
    end
  end

  def win_loss_records_overview
    @league.teams.inject({}) do |aggregate_record, team|
      home_games = @league.games.select do |game|
        game.home_team_id == team.team_id
      end
      home_win_loss = home_games.map do |game|
        game.outcome.include?("home") ? 1 : 0
      end
      away_record(team.team_id)
      if !home_win_loss.length.zero?
        aggregate_record[team.team_name] = {
          home: home_win_loss
        }
      end
      if !away_win_loss.length.zero?
        aggregate_record[team.team_name][:away] = away_win_loss
      end
      aggregate_record
    end
  end

  def home_record

  end

  def away_record(team_id)
    away_games = @league.games.select do |game|
      game.away_team_id == team_id
    end
    away_games.map do |game|
      game.outcome.include?("away") ? 1 : 0
    end
  end
end