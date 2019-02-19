module LeagueRecordStats

  def home_away_record(team_id, i_var, string)
    home_games = @league.games.select do |game|
      game.instance_variable_get("@#{i_var}")== team_id
    end
    home_games.map do |game|
      game.outcome.include?(string) ? 1 : 0
    end
  end

  def total_win_loss_records
    @league.teams.inject({}) do |home_loss_records, team|
      home_record = home_away_record(team.team_id, "home_team_id", "home")
      away_record = home_away_record(team.team_id, "away_team_id", "away")
      total_record =  home_record + away_record
      if !total_record.count.zero?
        home_loss_records[team.team_id] = total_record
      end
      home_loss_records
    end
  end

  def win_loss_records_overview
    @league.teams.inject({}) do |aggregate_record, team|
      home_win_loss = home_away_record(team.team_id, "home_team_id", "home")
      away_win_loss = home_away_record(team.team_id, "away_team_id", "away")
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