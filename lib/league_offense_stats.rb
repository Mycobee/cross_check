module LeagueOffenseStats


  def home_away_goals(team_id, i_var1, i_var2)
    home_away_goal_team = @league.games.select do |game|
      team_id == game.send(i_var1.to_sym)
    end
    home_away_goal_team.map {|game| game.send(i_var2.to_sym)}
  end

  def total_goals_made_by_team
   @league.teams.inject({}) do |teams_hash, team|
    away_game_goals = home_away_goals(team.team_id, "away_team_id", "away_goals")
    home_game_goals = home_away_goals(team.team_id, "home_team_id", "home_goals")
    if !away_game_goals.length.zero? || !home_game_goals.length.zero?
      teams_hash[team.team_id] = away_game_goals + home_game_goals
    end
    teams_hash
    end
  end

  def home_away_goals_scored(i_var1, i_var2)
    @league.teams.inject({}) do |teams_hash, team|
      home_away_goals = home_away_goals(team.team_id, i_var1, i_var2)
      teams_hash[team.team_id] = home_away_goals if !home_away_goals.count.zero?
      teams_hash
    end
  end

  def total_goals_when_visiting
    home_away_goals_scored("away_team_id", "away_goals")
  end

  def total_goals_when_at_home
    home_away_goals_scored("home_team_id", "home_goals")
  end
end
