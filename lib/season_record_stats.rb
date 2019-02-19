
module SeasonRecordStats
  def preseason_records(games_by_season)
    preseason_games = games_by_season.select {|game| game.type == "P"}
    preseason_games.inject({}) do |hash, game|
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

  # def total_season_win_loss(games_by_season)
  #   preseason_win_loss = preseason_records(games_by_season)
  #   regular_season_win_loss = regular_season_records(games_by_season)
  #   regular_season_win_loss.keys.inject({}) do |total_hash, team_id|
  #     if preseason_win_loss[team_id]
  #       total_season_win_loss = regular_season_win_loss[team_id] + preseason_win_loss[team_id]
  #       total_hash[team_id] = total_season_win_loss
  #     else
  #       total_hash[team_id] = regular_season_win_loss[team_id]
  #     end
  #     total_hash
  #   end
  # end

  def season_record_percentages(season_win_loss)
    season_win_loss.each do |season, win_loss|
      win_loss_percentage = ((win_loss.sum / win_loss.count.to_f) * 100).round(2)
      season_win_loss[season] = win_loss_percentage
    end
  end

  def seasons_games_by_team_id(season_id)
    games_by_season = @league.games.select {|game| game.season == season_id}
    team_games_by_game_id = @league.team_games.group_by {|team_game| team_game.game_id}
    games_by_season.inject([]) do |games_arr, game|
      matching_games = team_games_by_game_id[game.game_id]
      games_arr.concat(matching_games) if matching_games
      games_arr
    end
  end

  def shot_goal_records(season_id)
    season_games= seasons_games_by_team_id(season_id)
    season_games_by_team = season_games.group_by {|season_game| season_game.team_id}
    season_games_by_team.each do |team_id, team_games|
      total_shots = team_games.map {|team_game| team_game.shots}.sum
      total_goals = team_games.map {|team_game| team_game.goals}.sum
      shot_goal_ratio = (total_goals /  total_shots.to_f).round(4)
      season_games_by_team[team_id] = shot_goal_ratio
    end
  end

  def hits_records(season_id)
    season_games= seasons_games_by_team_id(season_id)
    season_games_by_team = season_games.group_by {|season_game| season_game.team_id}
    season_games_by_team.each do |team_id, team_games|
      total_hits = team_games.map {|team_game| team_game.hits}.sum
      season_games_by_team[team_id] = total_hits
    end
  end
end
