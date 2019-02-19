require_relative 'league_offense_stats'
require_relative 'league_defense_stats'
require_relative 'league_record_stats'

module LeagueStatistics
  include LeagueOffenseStats
  include LeagueDefenseStats
  include LeagueRecordStats

  def count_of_teams
    @league.teams.count
  end

  def calculate_percentage(team_hash, team_id)
    goals_by_team = team_hash[team_id]
    (goals_by_team.sum / goals_by_team.count.to_f)
  end

  def best_offense
    team_goals = total_goals_made_by_team # from LeagueOffenseStats
    best_offensive_id = team_goals.keys.max_by do |team_id|
      calculate_percentage(team_goals, team_id)
    end
    find_team_name(best_offensive_id)
  end

  def worst_offense
    team_goals = total_goals_made_by_team # from LeagueOffenseStats
    worst_offensive_id = team_goals.keys.min_by do |team_id|
      calculate_percentage(team_goals, team_id)     
    end
    find_team_name(worst_offensive_id)
  end

  def find_team_name(team_id)
    @league.teams.find {|team| team.team_id == team_id}.team_name
  end

  def best_defense
    team_goals_forfeited = total_goals_forfeited_by_team # from LeagueDefenseStats
    best_defensive_id = team_goals_forfeited.keys.min_by do |team_id|
      calculate_percentage(team_goals_forfeited, team_id)
    end
    find_team_name(best_defensive_id)
  end

  def worst_defense
    team_goals_forfeited = total_goals_forfeited_by_team # from LeagueDefenseStats
    worst_defensive_id = team_goals_forfeited.keys.max_by do |team_id|
      calculate_percentage(team_goals_forfeited, team_id)
    end
    find_team_name(worst_defensive_id)
  end

  def highest_scoring_visitor
    team_visitor_goals = total_goals_when_visiting # from LeagueOffenseStats
    highest_scoring_id = team_visitor_goals.keys.max_by do |team_id|
      calculate_percentage(team_visitor_goals, team_id)
    end
    find_team_name(highest_scoring_id)
  end

  def highest_scoring_home_team
    team_home_goals = total_goals_when_at_home # from LeagueOffenseStats
    best_home_scoring_id = team_home_goals.keys.max_by do |team_id|
      calculate_percentage(team_home_goals, team_id)
    end
    find_team_name(best_home_scoring_id)
  end

  def lowest_scoring_visitor
    team_visitor_goals = total_goals_when_visiting # from LeagueOffenseStats
    worst_visitor_scoring_id = team_visitor_goals.keys.min_by do |team_id|
      calculate_percentage(team_visitor_goals, team_id)
    end
    find_team_name(worst_visitor_scoring_id)
  end

  def lowest_scoring_home_team
    team_home_goals = total_goals_when_at_home #from LeagueOffenseStats
    worst_home_scoring_id = team_home_goals.keys.min_by do |team_id|
      calculate_percentage(team_home_goals, team_id)
    end
    find_team_name(worst_home_scoring_id)
  end

  def winningest_team
    win_loss_ratios = total_win_loss_records # from LeagueRecordStats
    winningest_id = win_loss_ratios.keys.max_by do |ratio|
      calculate_percentage(win_loss_ratios, ratio)
    end
    find_team_name(winningest_id)
  end

  def best_fans
    all_records = filter_win_loss_records
    best_fans_by_id = all_records.keys.max_by do |record|
      home_record = all_records[record][:home]
      away_record = all_records[record][:away]
      home_ratio = home_record.sum / home_record.count.to_f
      away_ratio = away_record.sum / away_record.count.to_f
      home_ratio - away_ratio  
    end
    find_team_name(best_fans_by_id)
  end

  def worst_fans
    all_records = filter_win_loss_records
    all_records.keys.select do |record|
      home_record = all_records[record][:home]
      away_record = all_records[record][:away]
      home_ratio = home_record.sum / home_record.count.to_f
      away_ratio = away_record.sum / away_record.count.to_f
      away_ratio - home_ratio > 0
    end
  end
end