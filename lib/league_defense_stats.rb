module LeagueDefenseStats
  def total_goals_forfeited_by_team
    @league.teams.inject({}) do |teams_hash, team|
      teams_hash[team.team_id] = []
      @league.games.each do |game|
        all_forfeited_goals = teams_hash[team.team_id]
        if team.team_id == game.away_team_id
          all_forfeited_goals << game.home_goals
        elsif team.team_id == game.home_team_id
          all_forfeited_goals << game.away_goals
        end
      end
      forfeited_count = teams_hash[team.team_id].count
      teams_hash.delete(team.team_id) if forfeited_count.zero?
      teams_hash
    end
  end
end