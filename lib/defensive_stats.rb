module DefensiveStats
  def total_goals_forfeited_by_team
    @league.teams.inject({}) do |teams_hash, team|
      teams_hash[team.short_name] = []
      @league.games.each do |game|
        all_forfeited_goals = teams_hash[team.short_name]
        if team.team_id == game.away_team_id
          all_forfeited_goals << game.home_goals
        elsif team.team_id == game.home_team_id
          all_forfeited_goals << game.away_goals
        else
          next
        end
      end
      forfeited_count = teams_hash[team.short_name].count
      teams_hash.delete(team.short_name) if forfeited_count.zero?
      teams_hash
    end
  end
end