
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

  # def best_season(team_id)
  #   season_hash = @league.games.group_by do |game|
  #     game.season
  #   end
  #   season_hash.each do |season, games|
  #     total_home_wins = season_hash[season].map {|game| game.home_team_id == team_id}
  #   end
  # end

  def worst_season(team_id)
  end

  def average_win_percentage(team_id)
    team_wins = @league.games.select do |game|
      game.home_team_id == team_id && game.outcome.include?("home") ||
      game.away_team_id == team_id && game.outcome.include?("away")
    end

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
  end

  def rival(team_id)
  end

  def biggest_team_blowout(team_id)
  end

  def worst_loss(team_id)
  end

  def head_to_head(team_id)
  end

  def seasonal_summary(team_id)
  end

end
