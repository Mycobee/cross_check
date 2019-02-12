require './lib/league_offense_stats'
require './lib/league_defense_stats'
require './lib/league_record_stats'

module LeagueStatistics
  include LeagueOffenseStats
  include LeagueDefenseStats
  include LeagueRecordStats

  def count_of_teams
    @league.teams.count
  end

  def best_offense
    team_goals = total_goals_made_by_team # from offensive_stats
    team_goals.keys.max_by do |team_name|
      goals_by_team = team_goals[team_name]
      (goals_by_team.sum / goals_by_team.count.to_f)
    end
  end

  def worst_offense
    team_goals = total_goals_made_by_team # from offensive_stats
    team_goals.keys.min_by do |team_name|
      goals_by_team = team_goals[team_name]
      (goals_by_team.sum / goals_by_team.count.to_f)
    end
  end

  def best_defense
    team_goals_forfeited = total_goals_forfeited_by_team # from defensive_stats
    team_goals_forfeited.keys.min_by do |team_name|
      goals_forfeited = team_goals_forfeited[team_name]
      (goals_forfeited.sum / goals_forfeited.count.to_f)
    end
  end

  def worst_defense
    team_goals_forfeited = total_goals_forfeited_by_team # from defensive_stats
    team_goals_forfeited.keys.max_by do |team_name|
      goals_forfeited = team_goals_forfeited[team_name]
      (goals_forfeited.sum / goals_forfeited.count.to_f)
    end
  end

  def highest_scoring_visitor
    team_visitor_goals = total_goals_when_visiting
    team_visitor_goals.keys.max_by do |team_name|
      visitor_goals = team_visitor_goals[team_name]
      (visitor_goals.sum / visitor_goals.count.to_f)
    end
  end

  def highest_scoring_home_team
    team_home_goals = total_goals_when_at_home
    team_home_goals.keys.max_by do |team_name|
      home_goals = team_home_goals[team_name]
      (home_goals.sum / home_goals.count.to_f)
    end
  end

  def lowest_scoring_visitor
    team_visitor_goals = total_goals_when_visiting
    team_visitor_goals.keys.min_by do |team_name|
      visitor_goals = team_visitor_goals[team_name]
      (visitor_goals.sum / visitor_goals.count.to_f)
    end
  end

  def lowest_scoring_home_team
    team_home_goals = total_goals_when_at_home
    team_home_goals.keys.min_by do |team_name|
      home_goals = team_home_goals[team_name]
      (home_goals.sum / home_goals.count.to_f)
    end
  end

  def winningest_team
    win_loss_ratios = total_win_loss_records
    win_loss_ratios.keys.max_by do |ratio|
      win_loss_tracker = win_loss_ratios[ratio]
      win_loss_tracker.sum / win_loss_tracker.count.to_f
    end
  end

  def best_fans
    all_records = win_loss_records_overview
    all_records.keys.max_by do |record|
      home_record = all_records[record][:home]
      away_record = all_records[record][:away]
      home_ratio = home_record.sum / home_record.count.to_f
      away_ratio = away_record.sum / away_record.count.to_f
      home_ratio - away_ratio  
    end
  end

  def worst_fans
    all_records = win_loss_records_overview
    all_records.keys.select do |record|
      home_record = all_records[record][:home]
      away_record = all_records[record][:away]
      home_ratio = home_record.sum / home_record.count.to_f
      away_ratio = away_record.sum / away_record.count.to_f
      require 'pry'; binding.pry
      home_ratio - away_ratio < 0
    end
  end
end