require './lib/offensive_stats'
require './lib/defensive_stats'
require './lib/percentage_stats'

module LeagueStatistics
  include OffensiveStats
  include DefensiveStats
  # include PercentageStats

  def count_of_teams
    @league.teams.count
  end

  def best_offense
    team_goals = total_goals_made_by_team # from offensive_stats
    team_goals.keys.max_by do |team_name|
      goals_by_team = team_goals[team_name]
      (goals_by_team.sum.to_f/goals_by_team.count).round(2)
    end
  end

  def worst_offense
    team_goals = total_goals_made_by_team # from offensive_stats
    team_goals.keys.min_by do |team_name|
      goals_by_team = team_goals[team_name]
      (goals_by_team.sum.to_f/goals_by_team.count).round(2)
    end
  end

  def best_defense
    team_goals_forfeited = total_goals_forfeited_by_team # from defensive_stats
    team_goals_forfeited.keys.min_by do |team_name|
      goals_forfeited = team_goals_forfeited[team_name]
      (goals_forfeited.sum.to_f / goals_forfeited.count).round(2)
    end
  end

  def worst_defense
    team_goals_forfeited = total_goals_forfeited_by_team # from defensive_stats
    team_goals_forfeited.keys.max_by do |team_name|
      goals_forfeited = team_goals_forfeited[team_name]
      (goals_forfeited.sum.to_f / goals_forfeited.count).round(2)
    end
  end
end