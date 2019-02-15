
module SeasonRecordStats
  def preseason_records(games_by_season)
    preseason_games = games_by_season.select {|game| game.type == "P"}
    preseason_win_loss = preseason_games.inject({}) do |hash, game|
      if !hash[game.away_team_id]
        hash[game.away_team_id] = []
      end

      if !hash[game.home_team_id]
        hash[game.home_team_id] = []
      end

      if hash[game.away_team_id]
        game.outcome.include?("away") ?
        hash[game.away_team_id] << 1 :
        hash[game.away_team_id] << 0
      end

      if hash[game.home_team_id]
        game.outcome.include?("home") ?
        hash[game.home_team_id] << 1 :
        hash[game.home_team_id] << 0
      end
      hash
    end
  end

  def regular_season_records(games_by_season)
    regular_season_games = games_by_season.select {|game| game.type == "R"}
    regular_season_games.inject({}) do |hash, game|
      if !hash[game.home_team_id]
        hash[game.home_team_id] = []
      end

      if !hash[game.away_team_id]
         hash[game.away_team_id] = []
      end

      if hash[game.home_team_id]
        game.outcome.include?("home") ?
        hash[game.home_team_id] << 1 :
        hash[game.home_team_id] << 0
      end

      if hash[game.away_team_id]
        game.outcome.include?("away") ?
        hash[game.away_team_id] << 1 :
        hash[game.away_team_id] << 0
      end
      hash
    end
  end

  def total_season_win_loss(games_by_season)
    preseason_win_loss = preseason_records(games_by_season)
    regular_season_win_loss = regular_season_records(games_by_season)
    regular_season_win_loss.keys.inject({}) do |total_hash, team_id|
      if preseason_win_loss[team_id]
        total_season_win_loss = regular_season_win_loss[team_id] + preseason_win_loss[team_id]
        total_hash[team_id] = total_season_win_loss
      else
        total_hash[team_id] = regular_season_win_loss[team_id]
      end
      total_hash
    end
  end

  def season_record_percentages(season_win_loss)
    season_win_loss.keys.each do |key|
      win_loss = season_win_loss[key]
      win_loss_percentage = ((win_loss.sum / win_loss.count.to_f) * 100).round(2)
      season_win_loss[key] = win_loss_percentage
    end
    season_win_loss
  end
end
