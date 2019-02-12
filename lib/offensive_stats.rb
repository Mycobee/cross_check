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
      teams_hash.delete(team.short_name) if teams_hash[team.short_name].count == 0
      teams_hash
    end
  end
end