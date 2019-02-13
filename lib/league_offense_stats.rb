module LeagueOffenseStats

  def away_goals(team_id)
    away_games = @league.games.select do |game|
      team_id == game.away_team_id
    end
    away_games.map {|game| game.away_goals}
  end

  def home_goals(team_id)
    home_games = @league.games.select do |game|
      team_id == game.home_team_id
    end
    home_games.map {|game| game.home_goals}
  end

  def total_goals_made_by_team
   @league.teams.inject({}) do |teams_hash, team|
    away_game_goals = away_goals(team.team_id)
    home_game_goals = home_goals(team.team_id)
    if !away_game_goals.length.zero? || !home_game_goals.length.zero?
      teams_hash[team.team_id] = away_game_goals + home_game_goals
    end
    teams_hash
    end
  end

  def total_goals_when_visiting
    @league.teams.inject({}) do |teams_hash, team|
      visitor_games = @league.games.select do |game| 
        team.team_id == game.away_team_id
      end
      visitor_goals = visitor_games.map {|game| game.away_goals}
      teams_hash[team.team_id] = visitor_goals if !visitor_goals.count.zero?
      teams_hash
    end
  end

  def total_goals_when_at_home
    @league.teams.inject({}) do |teams_hash, team|
      home_games = @league.games.select do |game|
        game.home_team_id == team.team_id
      end
      home_goals = home_games.map {|game| game.home_goals}
      teams_hash[team.team_id] = home_goals if !home_goals.count.zero?
      teams_hash
    end
  end
end