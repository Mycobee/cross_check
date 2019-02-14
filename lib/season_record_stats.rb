module SeasonRecordStats
  def regular_season_records(games_by_season)
    regular_season_games = games_by_season.select {|game| game.type == "R"}
    win_loss_record = regular_season_games.inject({}) do |hash, game|
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

    win_loss_record.each do |team_id, win_loss|
      win_loss_percentage = ((win_loss.sum / win_loss.count.to_f) * 100).round(2)
      win_loss_record[team_id] = win_loss_percentage
    end
    win_loss_record
  end

  def preseason_records(games_by_season)
    preseason_games = games_by_season.select {|game| game.type == "P"}
    win_loss_record = preseason_games.inject({}) do |hash, game|
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

    win_loss_record.each do |team_id, win_loss|
      win_loss_percentage = ((win_loss.sum / win_loss.count.to_f) * 100).round(2)
      win_loss_record[team_id] = win_loss_percentage
    end
    win_loss_record
  end

  def seasons_games_by_team_id(season_id)
    games_by_season = @league.games.select {|game| game.season == season_id}
    team_games_by_game_id = @league.team_games.group_by {|team_game| team_game.game_id}
    season_games = games_by_season.inject([]) do |games_arr, game|
      matching_games = team_games_by_game_id[game.game_id]
      games_arr.concat(matching_games) if matching_games
      games_arr
    end
    season_games.group_by {|season_game| season_game.team_id}
  end

  def shot_goal_records(season_id)
    season_games_by_team = seasons_games_by_team_id(season_id)
    season_games_by_team.each do |team_id, team_games|
      total_shots = team_games.map {|team_game| team_game.shots}.sum
      total_goals = team_games.map {|team_game| team_game.goals}.sum
      shot_goal_ratio = (total_goals /  total_shots.to_f).round(4)
      season_games_by_team[team_id] = shot_goal_ratio
    end
    season_games_by_team
  end

  def hits_records(season_id)
    season_games_by_team = seasons_games_by_team_id(season_id)
    season_games_by_team.each do |team_id, team_games|
      total_hits = team_games.map {|team_game| team_game.hits}.sum
      season_games_by_team[team_id] = total_hits
    end
    season_games_by_team
  end
end