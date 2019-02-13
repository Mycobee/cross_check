module SeasonStatistics
  def biggest_bust(season_id)
    games_by_season = @league.games.select {|game| game.season == season_id}

    preseason_games = games_by_season.select {|game| game.type == "P"}
    regular_season_games = games_by_season.select {|game| game.type == "R"}

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
    preseason_win_loss.keys.each do |key|
      win_loss = preseason_win_loss[key]
      win_loss_percentage = ((win_loss.sum / win_loss.count.to_f) * 100).round(2)
      preseason_win_loss[key] = win_loss_percentage
    end

    regular_season_win_loss = regular_season_games.inject({}) do |hash, game|
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

    regular_season_win_loss.keys.each do |key|
      win_loss = regular_season_win_loss[key]
      win_loss_percentage = ((win_loss.sum / win_loss.count.to_f) * 100).round(2)
      regular_season_win_loss[key] = win_loss_percentage
    end

    regular_season_win_loss.keys.each do |key|
      if !preseason_win_loss.key?(key)
        preseason_win_loss[key] = 0
      end
    end

    biggest_bust = regular_season_win_loss.keys.max_by do |key|
      regular_season_win_loss[key] - preseason_win_loss[key]
    end

  x =  @league.teams.find do |team|
      biggest_bust == team.team_id
    end.team_name

    require 'pry'; binding.pry

  end
end
