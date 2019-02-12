module LeagueOffenseStats
  def total_goals_made_by_team
    @league.teams.inject({}) do |teams_hash, team|
      teams_hash[team.team_name] = []
      @league.games.each do |game| 
        team_goals = teams_hash[team.team_name]
        if team.team_id == game.away_team_id
          team_goals << game.away_goals
        elsif team.team_id == game.home_team_id
          team_goals << game.home_goals
        else 
          next
        end
      end
      teams_hash
    end
  end

  def total_goals_when_visiting
    @league.teams.inject({}) do |teams_hash, team|
      visitor_games = @league.games.select do |game| 
        team.team_id == game.away_team_id
      end
      gamevisitor_games.map {||}
      teams_hash[team.team_name] = visitor_games
      teams_hash
    end
  end

  def total_goals_when_at_home
    @league.teams.inject({}) do |teams_hash, team|
      home_games = @league.games.select do |game|
        game.home_team_id == team.team_id
      end
      teams_hash[team.team_name] = home_games
      teams_hash
    end
  end
end