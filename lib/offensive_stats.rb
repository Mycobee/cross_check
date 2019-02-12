module OffensiveStats
  def total_goals_made_by_team
    @league.teams.inject({}) do |teams_hash, team|
      teams_hash[team.short_name] = []
      @league.games.each do |game| 
        team_goals = teams_hash[team.short_name]
        if team.team_id == game.away_team_id
          team_goals << game.away_goals
        elsif team.team_id == game.home_team_id
          team_goals << game.home_goals
        else 
          next
        end
      end
      goals_count = teams_hash[team.short_name].count
      teams_hash.delete(team.short_name) if goals_count.zero?
      teams_hash
    end
  end

  def total_goals_when_visiting
    @league.teams.inject({}) do |teams_hash, team|
      visitor_games = @league.games.select do |game| 
        team.team_id == game.away_team_id
      end
      visitor_goals = visitor_games.map { |game| game.away_goals }
      teams_hash[team.short_name] = visitor_goals if !visitor_goals.count.zero?
      teams_hash
    end
  end

  def total_goals_when_at_home
    @league.teams.inject({}) do |teams_hash, team|
      home_games = @league.games.select do |game|
        game.home_team_id == team.team_id
      end
      home_goals = home_games.map { |game| game.home_goals }
      teams_hash[team.short_name] = home_goals if !home_goals.count.zero?
      teams_hash
    end
  end
end