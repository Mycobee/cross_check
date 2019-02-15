module LeagueRecordStats
  def away_record(team_id)
    away_games = @league.games.select do |game|
      game.away_team_id == team_id
    end
    away_games.map do |game|
      game.outcome.include?("away") ? 1 : 0
    end
  end

  def home_record(team_id)
    home_games = @league.games.select do |game|
      game.home_team_id == team_id
    end
    home_games.map do |game|
      game.outcome.include?("home") ? 1 : 0
    end
  end

  def total_win_loss_records
    @league.teams.inject({}) do |home_loss_records, team|
      total_record = away_record(team.team_id) + home_record(team.team_id)
      if !total_record.count.zero?
        home_loss_records[team.team_id] = total_record
      end
      home_loss_records
    end
  end

  def win_loss_records_overview
    @league.teams.inject({}) do |aggregate_record, team|
      home_win_loss = home_record(team.team_id)
      away_win_loss = away_record(team.team_id)
      aggregate_record[team.team_id] = {}
      if !home_win_loss.length.zero? 
        aggregate_record[team.team_id][:home] = home_win_loss
      end
      if !away_win_loss.length.zero?
         aggregate_record[team.team_id][:away] = away_win_loss
      end
      aggregate_record
    end
  end

  def filter_win_loss_records
    all_records = win_loss_records_overview
    all_records.each do |team_id, record|
      all_records.delete(team_id) if !record[:home] || !record[:away]
    end
  end
end