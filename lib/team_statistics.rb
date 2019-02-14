
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

  def best_season(team_id)
    season_hash = @league.games.group_by do |game|
      game.season
    end
    season_hash.values.select do |games|
      require 'pry'; binding.pry
      
      team_games = games.select do |game|
        game.home_team_id == team_id ||
        game.away_team_id == taem_id
      end
    end
  end

  def worst_season(team_id)
  end

  def average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
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
