
module TeamStatistics

  def find_team(team_id)
    @league.teams.find do |team|
      team.team_id == team_id
    end
  end

  def team_info(team_id)
    team = find_team(team_id)
    team_info = team.instance_variables.map do |ivar|
      ivar.to_s.delete("@")
    end
    team_info.inject({}) do |hash, key|
      hash[key.to_sym] = team.instance_variable_get("@#{key}")
      hash
    end
  end

  def all_games_played(team_id)
    total_games = @league.games.select do |game|
      game.home_team_id == team_id
      game.away_team_id == team_id
    end
  end

  def home_games(team_id)
    total_games.select do |game|
      game.home_team_id == team_id
    end
  end

  def away_games(team_id)
    total_games.select do |game|
      game.away_team_id == team_id
    end
  end

  def winning_games(team_id)
    @league.games.select do |game|
      game.home_team_id == team_id && game.outcome.include?("home") ||
      game.away_team_id == team_id && game.outcome.include?("away")
    end
  end

  def losing_games(team_id)
    @league.games.select do |game|
      game.home_team_id == team_id && game.outcome.include?("away") ||
      game.away_team_id == team_id && game.outcome.include?("home")
    end
  end

  def best_season(team_id)
    season_hash = @league.games.group_by do |game|
      game.season
    end
    season_hash.each do |season, games|
      home_away_win_loss_array = games.map do |game|
        if game.home_team_id == team_id
          game.outcome.include?("home") ? 1 : 0
        end
        if game.away_team_id == team_id
          game.outcome.include?("away") ? 1 : 0
        end
      end
      home_away_win_loss_array = home_away_win_loss_array.select {|score| score}
      season_hash[season] = home_away_win_loss_array
    end
    season_result = {}
    season_hash.each do |season, scores|
      if scores.count == 0
        next
      else
      season_result[season] = scores.sum / scores.count
      end
    end
    x = season_result.keys.max_by do |season|
      season_result[season].to_i
    end
  end

  def worst_season(team_id)
    season_hash = @league.games.group_by do |game|
      game.season
    end
    season_hash.each do |season, games|
      home_away_win_loss_array = games.map do |game|
        if game.home_team_id == team_id
          game.outcome.include?("away") ? 1 : 0
        end
        if game.away_team_id == team_id
          game.outcome.include?("home") ? 1 : 0
        end
      end
      home_away_win_loss_array = home_away_win_loss_array.select {|score| score}
      season_hash[season] = home_away_win_loss_array
    end
    season_result = {}
    season_hash.each do |season, scores|
      if scores.count == 0
        next
      else
      season_result[season] = scores.sum / scores.count
      end
    end
    x = season_result.keys.max_by do |season|
      season_result[season].to_i
    end
    require 'pry'; binding.pry
  end

  def average_win_percentage(team_id)
    team_wins = winning_games(team_id)

    total_games = all_games_played(team_id)

    team_wins.count.to_f / total_games.count
  end

  def most_goals_scored(team_id)
    highest_home_game = home_games(team_id).max_by do |game|
      game.home_goals
    end

    highest_away_game = away_games(team_id).max_by do |game|
      game.away_goals
    end

    if highest_home_game > highest_away_game
      highest_home_game
    else highest_away_game
    end

  end

  def fewest_goals_scored(team_id)
    lowest_home_game = home_games(team_id).min_by do |game|
      game.home_goals
    end

    lowest_away_game = away_games(team_id).min_by do |game|
      game.away_goals
    end

    if lowest_home_game < lowest_away_game
      lowest_home_game
    else lowest_away_game
    end
  end

  def favorite_opponent(team_id)
    #Similar to best/worst season
    #1. Get all home games played by team_id
    #2. Group_by away_team_id
    #3. Find all games where home team wins
    #4. Get all away games played by team_id
    #5. Group_by home_team_id
  end

  def rival(team_id)
  end

  def biggest_team_blowout(team_id)
    team_wins = winning_games(team_id)

    team_wins.max_by do |game|
      (game.home_goals - game.away_goals).abs
    end
  end

  def worst_loss(team_id)
    team_losses = losing_games(team_id)

    team_losses.max_by do |game|
      (game.home_goals - game.away_goals).abs
    end
  end

  def head_to_head(team_id)
  end

  def seasonal_summary(team_id)
  end

end
