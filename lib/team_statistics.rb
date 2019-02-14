
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

  def best_season(team_id)
    season_hash = @league.games.group_by do |game|
      game.season
    end
    season_hash.each do |season, games|
      total_home_wins = season_hash[season].map {|game| game.home_team_id == team_id}
      end
    end
  end

  def worst_season(team_id)
  end

  def average_win_percentage(team_id)
    team_wins = @league.games.select do |game|
      game.home_team_id == team_id && game.outcome.include?("home") ||
      game.away_team_id == team_id && game.outcome.include?("away")
    end

    total_games = all_games_played(team_id)
    end

    team_wins.count.to_f / total_games.count
  end

  def most_goals_scored(team_id)
    highest_score_game = 0
    total_games = all_games_played(team_id)
    home_games = total_games.select do |game|
      game.home_team_id == team_id
    end
    home_games.each do |game|
      if game.home_goals > highest_score_game
        highest_score_game = game.home_goals
      end
    end
    away_games = total_games.select do |game|
      game.away_team_id == team_id
    end
    away_games.each do |game|
      if game.away_goals > highest_score_game
        highest_score_game = game.away_goals
      end
    highest_score_game
  end

  def fewest_goals_scored(team_id)
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
